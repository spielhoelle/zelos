# Contents of this file under shared license
Cucumber::Factory.add_steps(self)
RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
end

# RSpec without Rails
RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods

  config.before(:suite) do
    FactoryGirl.find_definitions
  end
end
