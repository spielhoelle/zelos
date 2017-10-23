
# Contents of this file under shared license
module NavigationHelpers

  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /^the welcome page$/
      '/'
    when /^the admin invoice page$/
      '/admin/entries'

    when /^the sign in page$/
      "/users/sign_in"

    when /^the sign up page$/
      "/users/sign_up"


    when /the (.*) page for that (.*) and (.*)/
      first_model = parameter_to_class_name($2)
      second_model = parameter_to_class_name($3)
      expect(first_model).to_not be_nil
      expect(second_model).to_not be_nil
      self.send(path_name($1), first_model.last, second_model.last)

    when /the (.*) page for that (.*)/
      model = parameter_to_class_name($2)
      expect(model.last).to_not be_nil
      self.send(path_name($1), model.last)

    when /the (.*) page for the (.*) with the (.*) "(.*)" and the (.*) with the (.*) "(.*)"/
      model_1 = parameter_to_class_name($2)
      attribute_name_1 = $3
      attribute_value_1 = $4

      model_2 = parameter_to_class_name($5)
      attribute_name_2 = $6
      attribute_value_2 = $7

      instance_1 = nil
      instance_2 = nil
      patiently do
        instance_1 = model_1.where("#{attribute_name_1}" => attribute_value_1).first
        instance_2 = model_2.where("#{attribute_name_2}" => attribute_value_2).first
        raise Capybara::ExpectationNotMet if instance_1.nil? or instance_2.nil?
      end
      self.send(path_name($1), instance_1, instance_2)


    when /the (.*) page for the (.*) with the (.*) "(.*)"/
      model = parameter_to_class_name($2)
      attribute_name = $3
      attribute_value = $4

      instance = nil
      patiently do
        instance = model.where("#{attribute_name}" => attribute_value).first
        raise Capybara::ExpectationNotMet if instance.nil? #retry
      end
      self.send(path_name($1), instance)

    when /the url "(.*)"/
      $1
    when /^the (.*) page with the current_event_override_year "(.*)"$/
      self.send(path_name($1), { current_event_override_year: $2 })
    else
      begin
        page_name =~ /^the (.*) page$/
        self.send(path_name($1))
      rescue NoMethodError, ArgumentError
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end

  def path_name components
    path_components = components.split(/\s+/)
    path_components.push('path').join('_')
  end

  # Works with different notations:
  # - "TicketType" => TicketType
  # - "ticket type" => TicketType
  # - "ticket-type" => TicketType
  # - "Ticket Type" => TicketType
  def parameter_to_class_name param
    param.underscore.parameterize.underscore.classify.constantize
  end

end

World(NavigationHelpers)
