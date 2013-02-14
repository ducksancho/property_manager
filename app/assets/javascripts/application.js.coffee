//= require jquery
//= require jquery_ujs

//= require messages
//= require form
//= require photos

$ ->
  alert("property[photos_attributes][dd][photo]".match(/\[([0-9]+)\]\[photo\]/)[1])
