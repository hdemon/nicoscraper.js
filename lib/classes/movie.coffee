class NicoScraper.Movie
  constructor: (@id, @source) ->

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
    gt = @_getThumbInfo()
    ma = @_mylistAtom()

    _scraped = ->
      if gt.scraped?
        gt[attr]()
      else
        ma[attr]()

    if @source?
      @source[attr]()
    else if gt[attr]? and ma[attr]?
      _scraped()
    else if gt[attr]?
      gt[attr]()
    else if ma[attr]?
      ma[attr]()


  _getThumbInfo: =>
    @__getThumbInfo ?= new NicoScraper.GetThumbInfo @id

  _mylistAtom: =>
    @__mylistAtom ?= new NicoScraper.MylistAtom @id
