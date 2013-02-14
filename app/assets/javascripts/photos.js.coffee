$ ->
  if $(".photo.field").length > 0
    $(".photo input[type=file]").change -> addPhotoField(this)
    $(".photo input[type=checkbox]").change -> hidePhotoField(this)
    
addPhotoField =(content)->
  photo_fields = $(content).parent().parent()
  edited_photo_index = parseInt($(content).attr("name").match(/\[([0-9]+)\]\[photo\]/)[1])
  last_photo_index = photo_fields.find(".photo").length - 1
  if last_photo_index <= edited_photo_index
    html = "<div class='photo field full new_photo_field'>"
    html += "<div class='fileField'>Browse To Photo</div>"
    html += "<input id='property_photos_attributes_#{last_photo_index+1}_photo' type='file' name='property[photos_attributes][#{last_photo_index+1}][photo]'></input>"
    html += "</div>"
    photo_fields.append(html)
    unless jQuery.browser.msie
      $(".new_photo_field input[type=file]").css("display", "none")
      $(".new_photo_field .fileField").css("display", "block")
      $(".new_photo_field .fileField").click (event) -> $(this).next("input[type=file]").click()
      $(".new_photo_field .fileField + input[type=file]").change -> $(this).prev(".fileField").html(input_file_display_text($(this).attr("id"), $(this).val()))
    $(".new_photo_field input[type=file]").change -> addPhotoField(this)
    $(".new_photo_field").removeClass("new_photo_field")
    
    
    # alert $(content).parent().child(".photo").last().html()
    # $(content).parent().append("aaa")
      # .replace /\[[0-9]+\]\[photo\]/, "[#{last_photo_index+1}][photo]"
      # .replace /_[0-9]+_photo/, "_#{last_photo_index+1}_photo"

hidePhotoField =(content)->
  if $(content).is(":checked")
    $(content).parent().parent().addClass("hidden")
