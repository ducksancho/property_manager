$ -> 
  if $("#messages").length > 0
    $("#messages").css("margin-top", "-70px")
    $("#messages").animate {marginTop: "-20px"}, 500
    setTimeout (->hideMessage()), 7000
    
hideMessage = ->
  $("#messages").animate {marginTop: "-70px"}, 1000
