module FormHelper
  def validation_messages(record)
    return unless record
    messages = []
    (record.is_a?(Array) ? record : [record]).each do |object|
      object.errors.full_messages.each {|message| messages.push(message)} if object.errors.size > 0
    end
    if messages.length > 0 
      content_tag(:div, nil, :class => "errors") do 
        messages.collect { |message| content_tag(:div, message, :class => "error") }.join.html_safe
      end
    end
  end
  # hash includes
  # :label_text => custom text on label
  # :input_hash => hash added to input ** do not include class ** (EX: f.text_field(field, hash[:field_hash]))
  # :value => input value
  # options for select field
  # :select_options => select objects
  # :select_value => value part in select option
  # :select_display => display part in select option
  # options for file
  # :file_text => default text showing on the file input field
  # extra options
  # :no_label => true will not show label
  def form_field(f, field, type, field_class, hash = {})    
    content_tag(:div, nil, :class => "field #{field_class}") do
      (hash[:no_label] ? raw("") : content_tag(:div, hash[:label_text] ? f.label(field, hash[:label_text]) : f.label(field), :class => "label")) +
      case type
      when :text
        content_tag(:div, f.text_field(field, hash[:input_hash] || {}), :class => "textField")
      when :password
        content_tag(:div, f.password_field(field, hash[:input_hash] || {}), :class => "textField")
      when :number
        content_tag(:div, f.number_field(field, hash[:input_hash] || {}), :class => "textField")
      when :select
        content_tag(:div, f.collection_select(field, hash[:select_options], hash[:select_value], hash[:select_display], hash[:input_hash] || {}), :class => "selectField")
      when :file
        content_tag(:div, hash[:file_text], :class => "fileField") +
        f.file_field(field, hash[:input_hash] || {})
      when :p
        content_tag(:div, nil, :class => "textField") do
          content_tag(:p, hash[:value], hash[:input_hash] || {})
        end
      end
    end
  end
  def display_field(m, method, type, field_class = "", hash = {})
    content_tag(:div, nil, :class => "field #{field_class}") do
      (hash[:no_label] ? raw("") : content_tag(:div, hash[:label_text] ? hash[:label_text] : method, :class => "label")) +
      case type
      when :p
        content_tag(:div, nil, :class => "textField") do
          content_tag(:p, m.try(method), hash[:input_hash] || {})
        end
      end
    end    
  end
end