module PhotosHelper
  def form_field_photo(f, field, field_class, hash = {})    
    content_tag(:div, nil, :class => "photo field #{field_class}") do
      (hash[:no_label] ? raw("") : content_tag(:div, hash[:label_text] ? f.label(field, hash[:label_text]) : f.label(field), :class => "label")) +
      if f.object.persisted?
        content_tag(:div, nil, :class => "full") do
          image_tag(f.object.photo_url(:small), :class => "left") +
          content_tag(:div, nil, :class => "check_full") do
            f.check_box(:photo_delete) +
            content_tag(:div, nil, :class => "icon") +
            f.label(:photo_delete)
          end
        end
      else
        content_tag(:div, hash[:file_text], :class => "fileField") +
        f.file_field(field, hash[:input_hash] || {})      
      end
    end
  end
end