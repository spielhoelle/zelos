require 'pry'
When /^I wait for "([^"]+)" seconds?$/ do |seconds|
  sleep seconds.to_f
end

When(/^I want to save and open that page$/) do
  save_and_open_page
end
When(/^I want to print the page body$/) do
  print page.body
end
When(/^I pry$/) do
  binding.pry
end

When /^I enter (?:"(.*)"|the following) as (.*)$/ do |*args|
  # cucumber is so forthcoming to check the regexp matching groups Cucumber::ArityMismatchError
  value = args[0]
  element_string = args[1]
  postpended_value = args[2]

  value = postpended_value if value.nil?
  references_attributes = !!element_string.match(/^#{SMACSSResolver.element_regex}#{SMACSSResolver.element_attribute_regex}$/)
  xpath = SMACSSResolver.new(element_string, skip_element: !references_attributes).xpath_for_read
  patiently_find_xpath(xpath).set(value)
end



Then(/^there should (still |not )?be (a|no) (\w+) with the (\w+) "([^"]*)" in the database$/) do |still_or_not, no_or_any, model, attribute_name, attribute_value|

  model = parameter_to_class_name(model)

  negate = (still_or_not == "not ") || (no_or_any == "no")
  instance = nil

  patiently do
    instance = model.where("#{attribute_name}" => attribute_value).first
    if negate
      raise Capybara::ExpectationNotMet if instance.present?
    else
      raise Capybara::ExpectationNotMet if instance.nil?
    end
  end

end

Then /^I must see (one|a|an|the|no|\d+) (?!table with )(.*)$/ do |qty, element_string|
  qty = ["a", "an", "the", "one"].include?(qty) ? 1 : qty.to_i
  skip_element = ! (/#{SMACSSResolver.element_attribute_regex}/ =~ element_string)
  binding.pry
  xpath = SMACSSResolver.new(element_string, skip_element: skip_element, count: qty).xpath_for_read

  patiently do
    unless (act = patiently_find_xpath(xpath, mode: :count)) == qty
      raise RSpec::Expectations.fail_with("Expected xpath #{xpath} to be found #{qty} times, found #{act}")
    end
  end
end
When /^I (.*)?click on the (.*)$/ do |click_type, element_string|
  xray = !!/xray-/.match(click_type)
  metal = !!/metal-/.match(click_type)
  references_attributes = !!element_string.match(/^#{SMACSSResolver.element_regex}#{SMACSSResolver.element_attribute_regex}$/)
  xpath = SMACSSResolver.new(element_string, skip_element: !references_attributes).xpath_for_read

  node = patiently_find_xpath(xpath, :visible => !xray)

  if metal.present?
    metal_click(xpath)
  else
    Capybara.current_driver == :poltergeist ? node.trigger('click') : node.click
  end
end

When /^I click the ([a-zA-Z0-9_\- ]+) (?:(?:of|for) (?:the|that)) ([a-zA-Z0-9_\- ]+)(?: with the ([a-zA-Z0-9_\- ]+) "(.*)")?$/ do |link_type, css_class, identifier_key, identifier_value|
  link_type, identifier_key, css_class = css_classify link_type, identifier_key, css_class
  xpath = xpath_for_read(field: link_type, css_class: css_class, identifier_key: identifier_key, identifier_value: identifier_value)

  node = patiently_find_xpath(xpath)
  Capybara.current_driver == :poltergeist ? node.trigger('click') : node.click
end
