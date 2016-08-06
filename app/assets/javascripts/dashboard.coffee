# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$ ->
  $(document).on 'ready', (evt) ->
    elem = document.getElementById('sleep-analysis')

    data = {
      x: [
        1
        2
        3
        4
        5
      ]
      y: [
        1
        2
        4
        8
        16
      ]
    }

    Plotly.plot elem, title:gon.sample_data, [ data ], margin: t: 0
