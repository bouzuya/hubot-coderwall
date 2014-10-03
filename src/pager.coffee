class Pager
  constructor: (items, itemsPerPage = 5) ->
    @items = items
    @itemsPerPage = itemsPerPage
    @page = 1
    @pages =  Math.floor((@items.length - 1) / @itemsPerPage) + 1

  currentPageItems: ->
    @items.filter (_, i) =>
      ((@page - 1) * @itemsPerPage <= i) && (i < @page * @itemsPerPage)

  next: ->
    @page += 1

  hasNext: ->
    @page <= @pages

module.exports.Pager = Pager
