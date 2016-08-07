# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$ ->
  $(document).on 'ready', (evt) ->

    # Sleep Analysis Chart.
    elem = document.getElementById('sleep-analysis')

    data = {
      x: gon.sleep_people_timestamps
      y: gon.sleep_people_counts,
    }

    layout = {
      xaxis: {
        rangemode: 'tozero'
      }
      yaxis: {
        range: [0,5],
        title: 'Sleep people'
      },
      margin:{
        top: 10
      }
    }

    console.log gon.sleep_people_timestamps
    console.log gon.sleep_people_counts

    Plotly.plot elem, [ data ], layout=layout, margin: t: 0

    # Map Chart.
    elem = document.getElementById('localization-map-chart')

    data2 = {
      x: [50,80],
      y: [50,73],
      mode: 'markers',
      type: 'scatter',
      marker:{
        size:15
      }
    }

    layout = {
      margin:{
        l:0,
        r:0,
        b:0,
        t:0
      },
      xaxis:{
        showgrid: false,
        zeroline: false,
        showline: false,
        autotick: true,
        ticks: '',
        showticklabels: false,
        range: [0,100]
      },
      yaxis:{
        showgrid: false,
        zeroline: false,
        showline: false,
        autotick: true,
        ticks: '',
        showticklabels: false,
        range: [0,100]
      },
      images: [
        {
          xref: "x",
          yref: "y",
          x: 0,
          y: 100,
          sizex: 100,
          sizey: 100,
          sizing: "stretch",
          opacity: 1,
          layer: "below",
          source: "map.png"
        }
      ]
    }

    Plotly.plot elem, [data2], layout=layout

#
#$(document).ready ->
#  slider = $('#slider-timeline-days').slider(
#    range: true
#    min: 200
#    max: 500
#    values: [
#      250
#      450
#    ]
#    slide: (event, ui) ->
#      console.log(ui.values)
#      return
#  )
#  return
#
#$(document).ready ->
#  slider = $('#slider-timeline-hours').slider(
#    range: true
#    min: 200
#    max: 500
#    values: [
#      250
#      450
#    ]
#    slide: (event, ui) ->
#      console.log(ui.values)
#      return
#  )
#  return



