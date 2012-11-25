class NicoScraper.Movie
  constructor: (@id) ->

  type: ->
    if _(@id).startsWith 'nm'
      'Niconico Movie Maker'
    else if _(@id).startsWith 'sm'
      'Smile Video'
    else
      'unknown'

  videoId: -> @id if @type() isnt 'unknown'
  threadId: -> @_source "threadId"
  title: -> @_source "title"
  description: -> @_source "description"
  thumbnailUrl: -> @_source "thumbnailUrl"
  firstRetrieve: -> @_source "firstRetrieve"
  published: -> @_source "published"
  updated: -> @_source "updated"
  infoDate: -> @_source "infoDate"
  length: -> @_source "length"
  movieType: -> @_source "movieType"
  sizeHigh: -> @_source "sizeHigh"
  sizeLow: -> @_source "sizeLow"
  viewCounter: -> @_source "viewCounter"
  commentNum: -> @_source "commentNum"
  mylistCounter: -> @_source "mylistCounter"
  lastResBody: -> @_source "lastResBody"
  watchUrl: -> @_source "watchUrl"
  thumbType: -> @_source "thumbType"
  embeddable: -> @_source "embeddable"
  noLivePlay: -> @_source "noLivePlay"
  tags: -> @_source "tags"


  _source: (attr) ->
    @_getThumbInfo()[attr]() if @_getThumbInfo().scraped and @_getThumbInfo()[attr]?
    @_mylistAtom()[attr]() if @_getThumbInfo().scraped and @_getThumbInfo()[attr]?

    @_getThumbInfo()[attr]() if @_getThumbInfo()[attr]?
    @_mylistAtom()[attr]() if @_mylistAtom()[attr]?

  _getThumbInfo: =>
    @__getThumbInfo ?= new NicoScraper.GetThumbInfo @id

  _mylistAtom: =>
    @__mylistAtom ?= new NicoScraper.GetThumbInfo @id
