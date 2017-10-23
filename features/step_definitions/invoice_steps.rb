Given /^some events with good customers$/ do
  customer = Customer.create(:name => "Good customer")
  customer.events << Entry.create(:start_time => Time.now + 2.hours, :name => 'superevent1')

  customer = Customer.create(:name => "Bad customer")
  customer.events << Entry.create(:start_time => Time.now + 2.hours, :name => 'foodevent1')
  customer.events << Entry.create(:start_time => Time.now + 2.hours, :name => 'foodevent2')

  customer = Customer.create(:name => "Slow customer")
  customer.events << Entry.create(:start_time => Time.now + 2.hours, :name => 'politixevent1')
  customer.events << Entry.create(:start_time => Time.now + 2.hours, :name => 'politixevent2')
  customer.events << Entry.create(:start_time => Time.now + 2.hours, :name => 'politixevent3')
  customer.events << Entry.create(:start_time => Time.now + 2.hours, :name => 'politixevent4')

end

Then(/^I want to list records$/) do
  puts Customer.all.inspect
  puts Item.all.inspect
end 

#Then(/^I just want to see events on friday$/) do
  #( page.all("section.monday", visible: false).count == 0 && page.all("section.friday", visible: false).count > 4)
#end 

#Then(/^I just want to see events all four days$/) do
  #puts page.all("section.monday", visible: false).count
  #puts page.all("section.friday", visible: false).count
  #page.all("section.monday", visible: false).count == 0
  #page.all("section.friday", visible: false).count > 4
  #Entry.delete_all
#end 


Then(/^there should be a subscription in the database$/) do
  expect(Subscription.count).to eq(1)
end

#When(/^I fill in the comment form$/) do
  #fill_in('Name', :with => 'John')
  #fill_in('Your Email', :with => 'john@bla.de')
  #fill_in('What do you think?', :with => 'Hello there!')
#end

When(/^I hit on the "([^"]+)" in the "([^"]*)"$/) do |label, selector|
  patiently do
    node = find("#{selector}", :text => label)
    node.click
  end
end

#Then(/^I should see no comment-entry$/) do
  #!page.has_css?('.user-post-comment')
#end 


# And (/^there is a post with the title "([^\"]*)" and the slug "([^\"]*)"$/) do |title, slug|
#   @post = Fcustomery(:post, :title => name)
#   @post.save!
# end


