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
        top: 0
      }
    }

    console.log gon.sleep_people_timestamps
    console.log gon.sleep_people_counts

    Plotly.plot elem, [ data ], layout=layout, margin: t: 0

    # Map Chart.
    elem = document.getElementById('localization-map-chart')

    localizations = {
      x: gon.localizations_x,
      y: gon.localizations_y,
      mode: 'markers',
      type: 'scatter',
      name: 'Personas',
      marker:{
        size:15,
        color: ['rgb(93, 164, 214)']
      }
    }

    reference_nodes = {
      x: gon.reference_localizations_x,
      y: gon.reference_localizations_y,
      mode: 'markers',
      type: 'scatter',
      name: 'Referencias'
      marker:{
        size: 15,
      }
    }

    layout = {
      width:800,
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
        range: [0,120]
      },
      yaxis:{
        showgrid: false,
        zeroline: false,
        showline: false,
        autotick: true,
        ticks: '',
        showticklabels: false,
        range: [0,120]
      },
      images: [
        {
          xref: "x",
          yref: "y",
          x: 0,
          y: 120,
          sizex: 120,
          sizey: 120,
          sizing: "stretch",
          opacity: 1,
          layer: "below",
          source: "map.png"
        }
      ]
    }

    Plotly.plot elem, [localizations,reference_nodes], layout=layout


$(document).ready ->
  $('#slider-timeline-days').ionRangeSlider({
    type: "double",
    min: 0,
    max: 100,
    from: 200,
    to: 500,
    grid: true
  });


