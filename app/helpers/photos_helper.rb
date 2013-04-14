module PhotosHelper
  def form_field_photo(f, v, i, field, field_class, hash = {})    
    content_tag(:div, nil, :class => "photo field #{field_class}") do
      (hash[:no_label] ? raw("") : content_tag(:div, hash[:label_text] ? v.label(field, hash[:label_text]) : v.label(field), :class => "label")) +
      if v.object.persisted?
        content_tag(:div, nil, :class => "full") do
          image_tag(v.object.photo_url(:small), :class => "left") +
          content_tag(:div, nil, :class => "check_full") do
            v.check_box(:photo_delete) +
            content_tag(:div, nil, :class => "icon") +
            v.label(:photo_delete)
          end
        end
      else
        content_tag(:div, nil, :class => "radio_full") do
          f.radio_button(:main_photo_index, i)+
          content_tag(:div, nil, :class => "icon")
        end + 
        content_tag(:div, hash[:file_text], :class => "fileField") +
        v.file_field(field, hash[:input_hash] || {})
      end
    end
  end
end
