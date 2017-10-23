module ApplicationHelper

  def bootstrap_class_for(flash_type)
    case flash_type
    when 'success'
      'alert-success'
    when 'error'
      'alert-danger'
    when 'alert'
      'alert-warning'
    when 'notice'
      'alert-info'
    else
      flash_type.to_s
    end
  end

  def class_for_controller
    "#{controller.controller_name} #{controller.controller_name}-#{controller.action_name} #{(user_signed_in? ? 'signed_in' : '')}"
  end

  def count_messages
    Message.all.count
  end

  def money_helper(number)
    number_to_currency(number, locale: :de,  unit: "€", separator: ",", delimiter: ".", format: "%n %u")
  end

end
