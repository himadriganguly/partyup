# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $("span.fav").on 'click', 'a', ->    
    $(this).html("<i class='fa fa-refresh fa-spin'></i> Please Wait...");
