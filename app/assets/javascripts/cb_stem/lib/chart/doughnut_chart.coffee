class ActiveAdmin.DoughnutChart

  constructor: (@options, @element) ->
    @$element = $(@element)

    defaults = {
      legend:
        display: true
        position: 'left'
        labels:
          usePointStyle: true
          fontSize: 10
      responsive: true
      maintainAspectRatio: true
      labels: false
      layout:
        padding: 10
    }

    @options = $.extend defaults, @options

    @_bind()

  # Private
  _bind: ->
    labels   = @$element.data('chart-label')
    data     = @$element.data('chart-data')
    options  = @$element.data('chart-options')
    colors   = @$element.data('chart-colors') || ChartColors
    @options = $.extend @options, options

    chartData =
      labels: labels
      datasets: [{
        borderWidth: 2
        borderColor: '#FFFFFF'
        backgroundColor: colors
        data: data
      }]

    return if !@element
    new Chart(
      @element,
      type:    'doughnut'
      data:    chartData
      options: @options
    )

$.widget.bridge 'aaDoughnutChart', ActiveAdmin.DoughnutChart
