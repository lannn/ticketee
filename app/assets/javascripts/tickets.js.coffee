# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
  $("a#add_another_file").click (event) ->
    event.preventDefault()
    url = "/files/new?number=" + $("#files input").length
    $.ajax
      type: "get"
      url: url
      success: (data) ->
        $("#files").append(data)
