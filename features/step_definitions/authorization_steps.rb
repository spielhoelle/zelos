
When(/^I sign in$/) do
  @user = FactoryBot.create(:user)
  login_as(@user, :scope => :user)
end

When(/^I sign in as an admin user$/) do
  @admin = FactoryBot.create(:admin_user)
  login_as(@admin_user, :scope => :admin_user)
end

When(/^I sign in as that (user|admin user)$/) do |role|
  role, model = model_and_role_from_string(role)

  instance = model.last
  login_as(instance, :scope => role.to_sym)
end

When(/^I sign in as the (user|admin user) with the (\w+) "([^"]*)"$/) \
  do |role, attribute_name, attribute_value|
  role, model = model_and_role_from_string(role)

  instance = model.where("#{attribute_name}" => attribute_value).first
  login_as(instance, :scope => role.to_sym)
end

When(/^I sign out$/) do
  logout(:user)
end

When(/^I sign out as admin user$/) do
  logout(:admin_user)
end

def model_and_role_from_string(string)
  role = string.parameterize.underscore
  model = parameter_to_class_name(string)
  [role, model]
end

Given(/^I am signed in$/) do
  @me = FactoryBot.create(:user)
  login_as(@me, :scope => :user)
end
