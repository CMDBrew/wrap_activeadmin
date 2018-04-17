class ActiveAdmin.ContentModelConstructor

  constructor: (@options, @element) ->
    @$element = $(@element)

    @draggable = {
      containment: 'document'
      helper:      'clone'
      cursor:      'move'
      appendTo:    'body'
    }

    @droppable = {
      containment: 'document'
      helper:      'clone'
      cursor:      'move'
    }

    options = {
      target: '.input-type-item'
    }

    @options = $.extend options, @options

    @_bind()

  # Private
  _bind: ->
    target  = @$element.data('droppable-target')
    debugger

    if(target)
      $target = $(target)
      $.extend(@droppable, { accepts: @element })
      $target.droppable @droppable

    $(@options.target, @$element).draggable @draggable

$.widget.bridge 'aaContentModelConstructor', ActiveAdmin.ContentModelConstructor
