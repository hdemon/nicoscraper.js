class NicoScraper.Mylist
  constructor: (@id) ->

  type: ->
    if _(@id).startsWith 'nm'
      'Niconico Movie Maker'
    else if _(@id).startsWith 'sm'
      'Smile Video'
    else
      'unknown'

  title: -> @_source "title"
  subTitle: -> @_source "subtitle"
  author: -> @_source "author"
  mylistId: -> @_source "mylistId"
  updatedTime: -> @_source "updated"
  movies: ->

  _source: (attr) ->
    @_mylistAtom()[attr]() if @_mylistAtom().scraped and @_mylistAtom()[attr]?
    @_mylist()[attr]() if @_mylist().scraped and @_mylist()[attr]?

    @_mylistAtom()[attr]() if @_mylistAtom()[attr]?
    @_mylist()[attr]() if @_mylist()[attr]?


  _mylistAtom: =>
    @__mylistAtom ?= new NicoScraper.mylistAtom @id

  _mylist: =>
    @__mylistAtom ?= new NicoScraper.mylistAtom @id
