# Contents of this file under shared license
# Configure Capybara for use with cucumber.
# https://github.com/jnicklas/capybara/blob/master/README.md

Capybara.configure do |config|
  config.default_driver = :poltergeist

  config.server_port = 8888 + ENV['TEST_ENV_NUMBER'].to_i

  # Capybara defaults to XPath selectors rather than Webrat's default of CSS3.
  # If you prefer to use XPath just remove this line and adjust any selectors
  # in your steps to use the XPath syntax.
  config.default_selector = :css

  # Ignore hidden elements on the page:
  config.ignore_hidden_elements = true

  config.default_max_wait_time = ENV.fetch('CAPYBARA_WAIT_TIME', 3).to_i
end
