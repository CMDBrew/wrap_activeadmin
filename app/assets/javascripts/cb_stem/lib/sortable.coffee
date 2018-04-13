class ActiveAdmin.Sortable

  constructor: (@options, @element) ->
    @$element = $(@element)

    defaults = {
      items: '.sortable-item'
      indexItem: '.sortable-index'
      stop: (e, ui) =>
        @_recompute_positions(ui.item.parent())
    }

    @options = $.extend defaults, @options

    @_bind()

  _recompute_positions: (parent)->
    position  = parseInt(1, 10)
    indexItem = @options.indexItem

    parent.children(@options.items).each ->
      $(@).find(indexItem).html(position++)


  # Private
  _bind: ->
    handle = @$element.data('sortable-handle')
    item   = @$element.data('sortable-item')

    if(handle)
      $.extend(@options, { handle: handle })

    if(item)
      $.extend(@options, { items: item })

    @$element.sortable @options

$.widget.bridge 'aaSortable', ActiveAdmin.Sortable
