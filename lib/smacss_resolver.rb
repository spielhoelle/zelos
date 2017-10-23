# Contents of this file under shared license
class SMACSSResolver

  def initialize(element_string = "", options = {})
    log_with_prefix :input, "#{element_string}   (options: #{options})", true
    @skip_element = !! options[:skip_element]
    @singularize  = options[:count].present? && options[:count].to_i > 1
    @element_string = element_string
    setup
  end

  def self.logger
    @logger ||= Logger.new("#{::File.expand_path('../../log',  __FILE__)}/smacss_resolver.log")
  end

  def log(value)
    SMACSSResolver.logger.info value
  end

  attr_reader :css_attribue_value

  def self.css_attr_reader(*array)
    array.each do |css_atribute_accessor|
      define_method css_atribute_accessor do
        css_classify(instance_variable_get("@#{css_atribute_accessor}"))
      end
    end
  end

  css_attr_reader :element_name, :css_module_name, :css_attribute_name, :context

  def element_regex=(css_attribute_regex)
    @element_regex = css_attribute_regex
    setup
  end

  def element_regex
    @element_regex ||= SMACSSResolver.element_regex
  end

  def xpath_for_read
    xpath = basic_xpath
    xpath += xpath_for_field(css_module_name, element_name) if element_name.present?
    log_with_prefix :xpath_for_read, xpath
    xpath
  end

  def xpath_for_select(value)
    xpath = basic_xpath
    xpath += xpath_for_select_option(css_module_name, element_name, value)
    log_with_prefix :xpath_for_select, xpath
    xpath
  end

  def xpath_for_select_text(value)
    xpath = basic_xpath
    xpath += xpath_for_select_text_option(css_module_name, element_name, value)
    log_with_prefix :xpath_for_select, xpath
    xpath
  end

  def xpath_for_select_text_option(css_class, field, value)
    xpath_for_field(css_class, field)+"/option[text()='#{value}']"
  end

  def xpath_for_redactor
    xpath = basic_xpath
    xpath += xpath_for_redactor_field(css_module_name, element_name) if element_name.present?
    log_with_prefix :xpath_for_redactor, xpath
    xpath
  end

  def xpath_for_radio(value)
    xpath = basic_xpath
    xpath += xpath_for_radio_button(css_module_name, element_name, value)
    log_with_prefix :xpath_for_radio, xpath
    xpath
  end

  private
  # xpaths - basic
  def basic_xpath
    xpath  = xpath_for_class_and_context(css_module_name, context)
    xpath += xpath_for_identifier(css_module_name, css_attribute_name, css_attribue_value) if css_attribue_value.present?
    xpath
  end

  def xpath_for_class(css_class)
    "//*[#{class_matcher_xpath(css_class)}]"
  end

  def xpath_for_class_or_id(css_selector)
    "//*[( #{class_matcher_xpath(css_selector)} or #{id_matcher_xpath(css_selector)} )]"
  end

  def xpath_for_list_context(css_class, css_context)
    list_item = css_context.singularize
    if (list_item != css_class)
      xpath_for_class(css_context) + xpath_for_classes(list_item, css_class)
    else
      xpath_for_class(css_context) + xpath_for_class(css_class)
    end
  end

  def xpath_for_classes(*css_classes)
    css_classes = [css_classes].flatten(1).map{|css_class|class_matcher_xpath(css_class)}.join(" and ")
    "//*[#{css_classes}]"
  end

  def id_matcher_xpath(css_id)
    "contains(concat(' ', normalize-space(@id), ' '), ' #{css_id} ')"
  end

  def class_matcher_xpath(css_class)
    "contains(concat(' ', normalize-space(@class), ' '), ' #{css_class} ')"
  end

  def xpath_for_class_and_context(css_class, css_context = nil)
    css_context.nil? ? xpath_for_class_or_id(css_class) : xpath_for_list_context(css_class, css_context)
  end

  def xpath_for_identifier(css_class, identifier_key, identifier_value)
    "[.//*[contains(concat(' ', normalize-space(@class), ' '), ' #{css_class}--#{identifier_key} ') and contains(., '#{identifier_value}')]]"
  end

  # qualified
  def xpath_for_field(css_class, field)
    xpath_for_class("#{css_class}--#{field}")
  end

  def xpath_for_select_option(css_class, field, value)
    xpath_for_field(css_class, field)+"/option[@value='#{value}']"
  end

  def xpath_for_redactor_field(css_class, field)
    xpath_for_class("redactor_#{css_class}--#{field}")
  end

  def xpath_for_radio_button(css_class, field, value)
    xpath_for_class("#{css_class}--#{field}-#{value}")
  end
  # misc

  def setup
    set_element_and_qualifiers
    set_module_and_attribute_names
  end

  def self.element_regex
    '([a-zA-Z0-9_\- ]+)'
  end

  def self.element_attribute_regex
    '(?: (?:of|in|for) (?:the|that) (.+))'
  end

  def css_classify(string)
    string.present? ? string.gsub(/ /,"--") : nil
  end

  # computing the string

  def set_element_and_qualifiers
    @element_name, @qualifiers = resolve_element_and_qualifiers(@element_string, @skip_element)
  end

  def set_module_and_attribute_names
    @css_module_name, @css_attribute_name, @css_attribue_value, @context = resolve_module_and_attribute_names(@qualifiers)
    puts css_module_name
    @css_module_name = css_module_name.singularize if @singularize
  end

  def resolve_element_and_qualifiers(element_string, skip_element = false)
    if(skip_element)
      [nil, element_string]
    elsif(match = element_string.match(/^#{self.element_regex}#{self.class.element_attribute_regex}$/))
      match.captures
    else
      [element_string.match(/^#{self.element_regex}$/).try(:[],0)]
    end
  end

  def resolve_module_and_attribute_names(qualifiers)
    [qualifiers.nil? ? nil : qualifiers.match(/^#{self.element_regex}(?: with the ([a-zA-Z0-9_\- ]+) "(.*)")?(?: among the ([a-zA-Z0-9_\- ]+))?$/).try(:captures)].flatten
  end

  def log_with_prefix(prefix, xpath, no_new_line=false)
    log "#{prefix}: #{xpath}"
    log " " unless no_new_line
  end

end
