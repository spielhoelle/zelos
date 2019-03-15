# Contents of this file under shared license
Cucumber::Factory.add_steps(self)

Given(/^There is a User$/) do
  User.create!(email: "user@test.com", password: "password#1")
  expect(User.first.email).to eq("user@test.com")
end



When(/^I sign in$/) do
  @user = FactoryBot.create(:user)
  login_as(@user, :scope => :user)
end
