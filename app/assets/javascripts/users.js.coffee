# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  $("img[rel]").overlay()
  $("a[rel]").overlay()
  $('#user_name').blur ->
    $.ajax(method: "GET", url:"verify?name=#{$('#user_name').val()}", data: "", success: (data) ->

      unless data.match('não')
        $('#name-validation').text(data).css("color","blue").css("text-decoration","none")
      else
        $('#name-validation').text(data).css("color","red").css("text-decoration","blink")
    
    )

