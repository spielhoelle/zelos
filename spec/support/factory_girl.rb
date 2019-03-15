# Contents of this file under shared license
Cucumber::Factory.add_steps(self)
RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
end

# RSpec without Rails
RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods

  config.before(:suite) do
    FactoryBot.find_definitions
  end
end
