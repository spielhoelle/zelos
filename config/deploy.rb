# config valid only for current version of Capistrano
set :application, 'zelos'
set :repo_url, YAML.load_file("./config/secrets.yml")["production"]["deploy_repository"]
set :branch, ENV['BRANCH'] if ENV['BRANCH']

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, '/var/www/my_app_name'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
set :log_level, :info

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')

# Default value for linked_dirs is []
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system', 'public/uploads', 'public/ckeditor_assets')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

set :rvm_ruby_version, '2.3.0'

set :user, "deploy"


namespace :deploy do

  #desc "run webpack build"
  #task :build do
    #on roles(:app) do
      #within release_path do
        #execute :npm, "run-script build"
      #end
    #end
  #end

  #after "npm:install", "deploy:build"

  #after "deploy:migrate", :seed
  
  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

  # and run 'cap production deploy:seed' to seed your database
  desc 'Runs rake db:seed'
  task :seed => [:set_rails_env] do
    on primary fetch(:migration_role) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, "db:seed"
        end
      end
    end
  end

  # after "deploy:migrate", :seed
  # after "deploy:seed", :precompile

end

# show latest production.log
# cap production logs:tail_rails
namespace :logs do
  desc "tail rails logs"
  task :tail_rails do
    on roles(:app) do
      execute "tail -f #{shared_path}/log/#{fetch(:rails_env)}.log"
    end
  end
end

# prod env Console. Usage:
# cap production rails:console
# chmod of /usr/local/rvm/rubies/ruby-2.2.5/.irbrc_histor must be 775
namespace :rails do
  desc 'Open a rails console `cap [staging] rails:console [server_index default: 0]`'
  task :console do
    server = roles(:app)[ARGV[2].to_i]

    puts "Opening a console on: #{server.hostname}...."

    cmd = "ssh #{server.user}@#{server.hostname} -t 'cd #{fetch(:deploy_to)}/current && RAILS_ENV=#{fetch(:rails_env)} bundle exec rails console'"

    puts cmd

    exec cmd
  end
end
desc 'Invoke a rake command on the remote server'
task :invoke, [:command] => 'deploy:set_rails_env' do |task, args|
  on primary(:app) do
    within current_path do
      with :rails_env => fetch(:rails_env) do
        rake args[:command]
      end
    end
  end
end


namespace :setup do
  desc "Upload database.yml file."
  task :upload_yml do
    on roles(:app) do
      execute "mkdir -p #{shared_path}/config"
      upload! StringIO.new(File.read("config/database.yml")), "#{shared_path}/config/database.yml"
      upload! StringIO.new(File.read("config/secrets.yml")), "#{shared_path}/config/secrets.yml"
    end
  end


  # desc "Symlinks config files for Nginx and Unicorn."
  # task :symlink_config do
  #   on roles(:app) do
  #     execute "rm -f /etc/nginx/sites-enabled/default"

  #     execute "ln -nfs #{current_path}/config/nginx.conf /etc/nginx/sites-enabled/#{fetch(:application)}"
  #     execute "ln -nfs #{current_path}/config/unicorn_init.sh /etc/init.d/unicorn_#{fetch(:application)}"
  #  end
  # end

end

namespace :nginx do
  desc "Reload nginx configuration"
  task :reload do
    on roles(:app) do
      run "#{sudo} /etc/init.d/nginx reload"
    end
  end
end

# Path of tests to be run, use array with empty string to run all tests
set :tests, ['']

namespace :deploy do
  desc "Runs test before deploying, can't deploy unless they pass"
  task :run_tests do
    test_log = "log/capistrano.test.log"
    tests = fetch(:tests)
    tests.each do |test|
      puts "--> Running cucumber tests, please wait ..."
      unless system "bundle exec cucumber #{test} > #{test_log} 2>&1"
        puts "--> Aborting deployment! One or more tests in '#{test}' failed. Results in: #{test_log}, but here are the last 100 lines"
        #system "tail -n 100 #{test_log}"
        exit;
      end
      puts "--> '#{test}' passed"
    end
    puts "--> All tests passed, continuing deployment"
    system "rm #{test_log}"
  end

  # Only allow a deploy with passing tests to be deployed
  before :deploy, "deploy:run_tests"

end

after 'deploy:symlink:release', 'letsencrypt:register_client'
after 'letsencrypt:register_client', 'letsencrypt:authorize_domain'
after 'letsencrypt:authorize_domain', 'letsencrypt:obtain_certificate'
#after 'letsencrypt:obtain_certificate', 'passenger:restart'
