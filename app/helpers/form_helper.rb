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
  def form_field(f, field, type, class_tag)
    content_tag(:div, nil, :class => "field #{class_tag}") do
      content_tag(:div, f.label(field), :class => "label") +
      case type
      when :text
        content_tag(:div, f.text_field(field), :class => "textField")
      end
    end
  end
end