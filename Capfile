# encoding: utf-8

require 'capistrano/deploy'
require 'capistrano/setup'

#set :stage, :production


require 'capistrano/bundler'
require 'capistrano/passenger'

require 'capistrano/rails'

require 'capistrano/rvm'
require 'capistrano/npm'
#require "capistrano/webpacked"
# Loads custom tasks from `lib/capistrano/tasks' if you have any defined.
 Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }
set :ssh_options, {:forward_agent => true}

