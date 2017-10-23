# Contents of this file under shared license
module SmacssHelpers
  def fuzzy_compare(value, expectiation)
    array = [value, expectiation].map{|string| " #{ActionController::Base.helpers.strip_tags(string)} ".gsub(/\s+/," ")}
    expect(array[0]).to eq array[1]
  end

  def metal_click(selector)
    selector = "document.evaluate( \"#{selector}\" ,document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null ).singleNodeValue"

    half_with = page.evaluate_script("$(#{selector}).width()") / 2
    half_height = page.evaluate_script("$(#{selector}).height()") / 2
    offset = page.evaluate_script("$(#{selector}).offset()")

    x = offset["left"] + half_with
    y = offset["top"]  + half_height
    page.execute_script("$(document.elementFromPoint(#{x}, #{y})).first().click()")
  end

  def css_classify(*array)
    array = array.collect{|string| string.present? ? string.gsub(/ /,"--") : string }
    array.length < 2 ? array.first : array
  end

  # def xpath_for_write(options)
  #   options[:field] = "#{options[:field]}--input"
  #   xpath_for_read(options)
  # end

  def xpath_for_read(options)
    xpath  = xpath_for_class(options[:css_class])
    xpath += xpath_for_identifier(options[:css_class], options[:identifier_key], options[:identifier_value]) if options[:identifier_key].present?
    xpath += xpath_for_field(options[:css_class], options[:field]) if options[:field].present?
    xpath
  end

  def xpath_for_redactor(options)
    xpath  = xpath_for_class(options[:css_class])
    xpath += xpath_for_identifier(options[:css_class], options[:identifier_key], options[:identifier_value]) if options[:identifier_key].present?
    xpath += xpath_for_redactor_field(options[:css_class], options[:field]) if options[:field].present?
    xpath
  end

  def xpath_for_radio(options)
    xpath  = xpath_for_class(options[:css_class])
    xpath += xpath_for_identifier(options[:css_class], options[:identifier_key], options[:identifier_value]) if options[:identifier_key].present?
    xpath += xpath_for_radio_button(options[:css_class], options[:field], options[:value])
    xpath
  end

  def xpath_for_select(options)
    xpath  = xpath_for_class(options[:css_class])
    xpath += xpath_for_identifier(options[:css_class], options[:identifier_key], options[:identifier_value]) if options[:identifier_key].present?
    xpath += xpath_for_select_box(options[:css_class], options[:field], options[:value])
    xpath
  end

  def xpath_for_checkbox(options)
    xpath  = xpath_for_class(options[:css_class])
    xpath += xpath_for_identifier(options[:css_class], options[:identifier_key], options[:identifier_value]) if options[:identifier_key].present?
    xpath += xpath_for_check_box(options[:css_class], options[:field], options[:value])
    xpath
  end

  def xpath_for_select_box(css_class, field, value)
    xpath_for_field(css_class, field)+"/option[@value='#{value}']"
  end

  def xpath_for_check_box(css_class, field, value)
    xpath_for_field(css_class, field)+"/option[@value='#{value}']"
  end

  def xpath_for_radio_button(css_class, field, value)
    xpath_for_class("#{css_class}--#{field}-#{value}")
  end

  def xpath_for_class(css_class)
    "//*[contains(concat(' ', normalize-space(@class), ' '), ' #{css_class} ')]"
  end

  def xpath_for_field(css_class, field)
    xpath_for_class("#{css_class}--#{field}")
  end

  def xpath_for_redactor_field(css_class, field)
    xpath_for_class("redactor_#{css_class}--#{field}")
  end

  def xpath_for_identifier(css_class, identifier_key, identifier_value)
    "[.//*[contains(concat(' ', normalize-space(@class), ' '), ' #{css_class}--#{identifier_key} ') and contains(., '#{identifier_value}')]]"
  end

  def patiently_find_xpath(xpath, options = {})
    mode = options.delete(:mode)
    patiently do
      if mode.present?
        if mode == :count
          node_or_nodes = all(:xpath, xpath, options).count
        else
          node_or_nodes = all(:xpath, xpath, options)
        end
      else
        node_or_nodes = find(:xpath, xpath, options)
      end
    end
  end

end

World(SmacssHelpers)
