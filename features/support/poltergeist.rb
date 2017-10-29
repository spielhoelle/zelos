require 'capybara/poltergeist'


Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app,
    timeout: 15,
    inspector: true,
    js_errors: false,
    port: 44678 + ENV['TEST_ENV_NUMBER'].to_i,
    window_size: [1280, 1600],
    # phantomjs_options: ['--load-images=no', '--ignore-ssl-errors=yes', '--web-security=false']
    # sadly, not loading image is not speeding up things...
    phantomjs_options: ['--load-images=no', '--web-security=false', '--proxy-type=none']
  )
end

ToleranceForSeleniumSyncIssues::RETRY_ERRORS << 'Capybara::Poltergeist::ObsoleteNode'
