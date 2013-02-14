$ ->  
  unless jQuery.browser.msie
    $("input[type=file]").css("display", "none")
    $(".fileField").css("display", "block")
    $(".fileField").click (event) -> $(this).next("input[type=file]").click()
    $(".fileField + input[type=file]").change -> $(this).prev(".fileField").html(input_file_display_text($(this).attr("id"), $(this).val()))

# override this method to display different text on input file field
this.input_file_display_text =(id, filename)->
  if id.match(/photos_attributes/)
    message = 
      if filename.match(/.(jpg|jpeg|gif|png)$/i)
        "<span class='blue'>Image file: </span>"
      else
        "<span class='red'>Unsupported file: </span>"
      
    message+filename.split('/').pop()
  else
    filename.split('/').pop()
