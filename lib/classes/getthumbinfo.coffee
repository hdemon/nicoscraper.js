class NicoScraper.GetThumbInfo extends Module
  @extend NicoScraper.Utility

  constructor: (@id, @scraped=false) ->

  body: ->
    if @_body?
      @_body
    else
      @scraped = true
      @_body = $(NicoScraper.Connection "http://ext.nicovideo.jp/api/getthumbinfo/#{@id}")

  title: ->
    @_title ?= @body().find('title').text()

  description: ->
    @_description ?= @body().find('description').text()

  thumbnailUrl: ->
    @_thumbnailUrl ?= @body().find('thumbnail_url').text()

  firstRetrieve: ->
    @_firstRetrieve ?= @body().find('first_retrieve').text()

  length: ->
    @_length ?= @_convertToSec @body().find('length').text()

  movieType: ->
    @_movieType ?= @body().find('movie_type').text()

  sizeHigh: ->
    @_sizeHigh ?= Number @body().find('size_high').text()

  sizeLow: ->
    @_sizeLow ?= Number @body().find('size_low').text()

  viewCounter: ->
    @_viewCounter ?= Number @body().find('view_counter').text()

  commentNum: ->
    @_commentNum ?= Number @body().find('comment_num').text()

  Counter: ->
    @_mylistCounter ?= Number @body().find('mylist_counter').text()

  lastResBody: ->
    @_lastResBody ?= @body().find('last_res_body').text()

  watchUrl: ->
    @_watchUrl ?= @body().find('watch_url').text()

  thumbType: ->
    @_thumbType ?= @body().find('thumb_type').eq(0).text()

  embeddable: ->
    @_embeddable ?= Number @body().find('embeddable').text()

  noLivePlay: ->
    @_noLivePlay ?= Number @body().find('no_live_play').text()

  tags: ->
    @_tags ?= @_parseTags()


  _parseTags : ->
    array = []

    @body().find('tag').each (i, e) ->
      e = $(e)
      obj = { string : e.text() }
      category = e.attr 'category'
      lock = e.attr 'lock'
      _.extend obj, { category : Number category } unless _.isEmpty category
      _.extend obj, { lock : Number lock } unless _.isEmpty lock

      array.push obj

    array
