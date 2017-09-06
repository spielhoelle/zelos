# server-based syntax
# ======================
# Defines a single server with a list of roles and multiple properties.
# You can define all roles on a single server, or split them:

# server 'example.com', user: 'deploy', roles: %w{app db web}, my_property: :my_value
# server 'example.com', user: 'deploy', roles: %w{app web}, other_property: :other_value
# server 'db.example.com', user: 'deploy', roles: %w{db}



# role-based syntax
# ==================

# Defines a role with one or multiple servers. The primary server in each
# group is considered to be the first unless any  hosts have the primary
# property set. Specify the username and a domain or IP for the server.
# Don't use `:all`, it's a meta role.

# Single server example
role :app, "deploy@#{YAML.load_file("./config/secrets.yml")["production"]["deploy_server_ip"]}"
role :web, "deploy@#{YAML.load_file("./config/secrets.yml")["production"]["deploy_server_ip"]}"
role :db,  "deploy@#{YAML.load_file("./config/secrets.yml")["production"]["deploy_server_ip"]}"

# Configuration
# =============
# You can set any configuration variable like in config/deploy.rb
# These variables are then only loaded and set in this stage.
# For available Capistrano configuration variables see the documentation page.
# http://capistranorb.com/documentation/getting-started/configuration/
# Feel free to add new variables to customise your setup.

server YAML.load_file("./config/secrets.yml")["production"]["deploy_server_ip"],
       :user => "deploy",
       :roles => %w(web app db),
       :ssh_options => {
         :keepalive => true,
         :keepalive_interval => 60 #seconds
       }

set :letsencrypt_contact_email, 'tfkuhnert@gmail.com'
set :letsencrypt_dir, "#{shared_path}/config/letsencrypt"
set :letsencrypt_endpoint, 'https://acme-v01.api.letsencrypt.org/'
set :letsencrypt_private_key_path, "#{fetch(:letsencrypt_dir)}/private_key.pem"
set :letsencrypt_authorize_domains, 'zelos.thomaskuhnert.com www.zelos.thomaskuhnert.com'
set :letsencrypt_certificate_request_domains, 'zelos.thomaskuhnert.com www.zelos.thomaskuhnert.com'
# Custom SSH Options
# ==================
# You may pass any option but keep in mind that net/ssh understands a
# limited set of options, consult the Net::SSH documentation.
# http://net-ssh.github.io/net-ssh/classes/Net/SSH.html#method-c-start
#
# Global options
# --------------
#  set :ssh_options, {
#    keys: %w(/home/rlisowski/.ssh/id_rsa),
#    forward_agent: false,
#    auth_methods: %w(password)
#  }
#
# The server-based syntax can be used to override options:
# ------------------------------------
# server 'example.com',
#   user: 'user_name',
#   roles: %w{web app},
#   ssh_options: {
#     user: 'user_name', # overrides user setting above
#     keys: %w(/home/user_name/.ssh/id_rsa),
#     forward_agent: false,
#     auth_methods: %w(publickey password)
#     # password: 'please use keys'
#   }
