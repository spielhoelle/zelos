source 'https://rubygems.org'
git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end
gem 'rails', '~> 5.0.1'
gem 'sqlite3'
gem 'puma', '~> 3.0'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'jquery-rails'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'mysql2'

group :development, :test do
  gem 'byebug', platform: :mri
  gem 'rspec-rails', '~> 3.4'
  gem 'rspec-mocks'
  gem "factory_girl_rails", "~> 4.0"
  gem 'rspec-collection_matchers'
  gem 'ffaker'  
  gem 'selenium-webdriver'
  gem 'pry'
  gem 'pry-nav'
  gem 'pry-rails'
  gem 'pry-rescue'
  gem 'pry-remote'
  gem 'pry-stack_explorer'
  gem 'pry-byebug', '~> 1.3'
end

group :test do
  gem 'launchy'
  gem 'rspec_junit_formatter'
  gem 'cucumber-rails', :require => false
  gem 'database_cleaner'
  gem 'cucumber_factory'
  gem 'timecop'
  gem 'capybara'
  gem 'poltergeist'
  gem 'nokogiri'
  gem 'shoulda-matchers', '~> 3.1'
  gem 'rspec_candy'
  gem 'rspec-its'
  gem 'spreewald', '~> 1.5.2'
  gem 'email_spec'
  gem 'simplecov'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'seed_dump'
  gem 'capistrano'
  gem 'capistrano-rails'
  gem 'capistrano-npm'
  gem 'capistrano-bundler'
  gem 'capistrano-rvm'
  gem 'capistrano-passenger', '>= 0.1.1'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem 'autoprefixer-rails'
gem "haml-rails"
gem "paperclip", "~> 5.0.0"
gem 'devise'
gem 'mail_form'

source 'https://rails-assets.org' do
  gem 'rails-assets-tether', '>= 1.3.3'
end

gem 'materialize-sass'
gem 'rails-settings-cached'
gem 'nested_form_fields'

gem 'pdfkit'
gem 'render_anywhere'
gem 'wkhtmltopdf-binary'
gem "chartkick"
gem 'jquery-ui-rails'
gem 'rails_sortable'

gem 'groupdate'
gem 'paper_trail'
gem 'diffy' 
gem 'whenever', :require => false
gem 'acme-client', require: false

gem 'rqrcode' 
gem 'rollbar'
gem "paperclip", "~> 5.0.0"
