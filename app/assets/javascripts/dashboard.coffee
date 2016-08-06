# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$ ->
  $(document).on 'ready', (evt) ->
    elem = document.getElementById('sleep-analysis')

    data = {
      x: gon.sleep_people_timestamps
      y: gon.sleep_people_counts
    }

    layout = {
      xaxis: {
        rangemode: 'tozero'
      }
      yaxis: {
        range: [0,5],
        title: 'Sleep people'
      }
    }

    console.log gon.sleep_people_timestamps
    console.log gon.sleep_people_counts

    Plotly.plot elem, [ data ], layout=layout, margin: t: 0
