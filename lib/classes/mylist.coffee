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
    movies = {}

    for videoId, movie of @_source("movies")
      movies[videoId] = new NicoScraper.Movie videoId, movie

    movies

  movie: (id) ->
    @movies()[id]


  _source: (attr) ->
    ma = @_mylistAtom()
    mh = @_mylistHtml()

    if ma[attr]? and mh[attr]?
      if ma.scraped?
        ma[attr]()
      else if mh.scraped?
        mh[attr]()
      else
        ma[attr]()
    else if ma[attr]?
      ma[attr]()
    else if mh[attr]?
      mh[attr]()

  _mylistAtom: =>
    @__mylistAtom ?= new NicoScraper.MylistAtom @id

  _mylistHtml: =>
    @__mylistAtom ?= new NicoScraper.MylistAtom @id
