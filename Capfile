# encoding: utf-8

require 'capistrano/deploy'
require 'capistrano/setup'

#set :stage, :production


require 'capistrano/bundler'
require 'capistrano/passenger'

require 'capistrano/rails'

require 'capistrano/rvm'
require 'capistrano/npm'
require "whenever/capistrano"
#require "capistrano/webpacked"
# Loads custom tasks from `lib/capistrano/tasks' if you have any defined.
set :ssh_options, {:forward_agent => true}

Dir.glob('lib/capistrano/tasks/**/*.rake').each { |r| import r }
