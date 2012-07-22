_  = require 'underscore'
_.str = require 'underscore.string'
_.mixin _.str.exports()
_.str.include 'Underscore.string', 'string'
$ = require 'jquery'
Zombie = require 'zombie'

NicoQuery = 
  Source : {}
moduleKeywords = ['extended', 'included']

class Module
  @extend: (obj) ->
    for key, value of obj when key not in moduleKeywords
      @[key] = value

    # obj.extended?.apply(@)
    this

  @include: (obj) ->
    for key, value of obj when key not in moduleKeywords
      # Assign properties to the prototype
      @::[key] = value

    # obj.included?.apply(@)
    this

    class NicoQuery.Utility
  _convert_to_sec : (string) ->
    s = string.split ':'
    minute = Number s[0]
    second = Number s[1]
    minute * 60 + second

  _convert_to_unix_time : (string) ->
    s = string.match /\w+/g
    new Date(s[0], s[1] - 1, s[2], s[3], s[4], s[5], 0) / 1000
class NicoQuery.Connection
  constructor : (@uri, @callback) ->
    @callback.success ?= ->
    @callback.failed ?= ->

    zombie = new Zombie
    zombie.runScripts = false

    zombie.visit @uri, (error, browser, status) =>
      @browser = browser
      @status = status
      @error = error

      switch @status
        when 200
          @callback.success @browser
        when 404
          @callback.failed @error, @status
          @callback._404 @error, @status
        when 500
          @callback.failed @error, @status
          @callback._500 @error, @status
        when 503
          @callback.failed @error, @status
          @callback._503 @error, @status
class NicoQuery.Source.EntryAtom extends Module
  @extend NicoQuery.Utility

  constructor : (@body) ->
    @b = $(@body)
    @c = @b.find 'content'

    @getAllInfo()

    @b = @c = null

  getAllInfo : ->
    @title()
    @videoId()
    @timelikeId()
    @publishedTime()
    @updatedTime()
    @thumbnailUrl()
    @description()
    @length()
    @infoDate()

  title : ->
    @title = @b.find('title').text()

  videoId : ->
    @videoId = @b.find('link').attr('href').split('/')[4]

  timelikeId : ->
    @timelikeId = Number @b.find('id').text().split(',')[1].split(':')[1].split('/')[2]

  publishedTime : ->
    @published = @b.find('published').text()

  updatedTime : ->
    @updated = @b.find('updated').text()

  thumbnailUrl : ->
    @thumbnailUrl = @c.find('img').attr('src')

  description : ->
    @description = @c.find('.nico-description').text()

  length : ->
    @length = @_convert_to_sec @c.find('.nico-info-length').text()

  infoDate : ->
    @infoDate = @_convert_to_unix_time @c.find('.nico-info-date').text()

module.exports = NicoQuery.EntryAtom
class NicoQuery.Source.GetThumbInfo extends Module
  @extend NicoQuery.Utility

  constructor : (@xml) ->
    b = $(@xml).find('thumb')

    @title = b.find('title').text()
    @description = b.find('description').text()
    @thumbnailUrl = b.find('thumbnail_url').text()
    @firstRetrieve = b.find('first_retrieve').text()
    @length = @_convert_to_sec b.find('length').text()
    @movieType = b.find('movie_type').text()
    @sizeHigh = Number b.find('size_high').text()
    @sizeLow = Number b.find('size_low').text()
    @viewCounter = Number b.find('view_counter').text()
    @commentNum = Number b.find('comment_num').text()
    @mylistCounter = Number b.find('mylist_counter').text()
    @lastResBody = b.find('last_res_body').text()
    @watchUrl = b.find('watch_url').text()
    @thumbType = b.find('thumb_type').eq(0).text()
    @embeddable = Number b.find('embeddable').text()
    @noLivePlay = Number b.find('no_live_play').text()

    @tags = @_parseTags()

  _parseTags : ->
    xml_jp = $(@xml).find('tags[domain=jp]')
    xml_tw = $(@xml).find('tags[domain=tw]')

    { 'jp' : @_objectize xml_jp }

  _objectize : (xml) ->
    array = []

    xml.find('tag').each (i, e) ->
      e = $(e)
      obj = { string : e.text() }
      category = e.attr 'category'
      lock = e.attr 'lock'
      _.extend obj, { category : Number category } unless _.isEmpty category
      _.extend obj, { lock : Number lock } unless _.isEmpty lock

      array.push obj

    return array
class NicoQuery.Movie
  constructor : (@provisional_id) ->
    @type = @getType()
    @source =
      getThumbInfo: {}
      mylistAtom: {}
      mylistHtml: {}
      html: {}

  getAtom : (callback) ->
    connection = new NicoQuery.Connection @uri + "?rss=atom",
      success : (browser) =>
        @source.getThumbInfo = new NicoQuery.Source.GetThumbInfo browser.window.document.innerHTML
        console.log "callback"
        callback @

  getType : ->
    switch _.startsWith @provisional_id
      when 'nm'
        'Niconico Movie Maker'
      when 'sm'
        'Smile Video'
      else
        'unknown'

  videoId : ->
    @provisional_id

  title : ->
    @source.getThumbInfo.title

  description : ->
    @source.getThumbInfo.description

  thumbnailUrl : ->
    @source.getThumbInfo.thumbnailUrl

  firstRetrieve : ->
    @source.getThumbInfo.firstRetrieve

  length : ->
    @source.getThumbInfo.length

  movieType : ->
    @source.getThumbInfo.movieType

  sizeHigh : ->
    @source.getThumbInfo.sizeHigh

  sizeLow : ->
    @source.getThumbInfo.sizeLow

  viewCounter : ->
    @source.getThumbInfo.viewCounter

  commentNum : ->
    @source.getThumbInfo.commentNum

  mylistCounter : ->
    @source.getThumbInfo.mylistCounter

  lastResBody : ->
    @source.getThumbInfo.lastResBody

  watchUrl : ->
    @source.getThumbInfo.watchUrl

  thumbType : ->
    @source.getThumbInfo.thumbType

  embeddable : ->
    @source.getThumbInfo.embeddable

  noLivePlay : ->
    @source.getThumbInfo.noLivePlay

class NicoQuery.Mylist
  constructor : (@mylist_id) ->
    @uri = "http://www.nicovideo.jp/mylist/#{@mylist_id}"

    @source =
      atom : {}
      html : {}

  getAtom : (callback) ->
    connection = new NicoQuery.Connection @uri + "?rss=atom",
      success : (browser) =>
        @source.atom = new NicoQuery.Source.MylistAtom browser.window.document.innerHTML
        console.log "callback"
        callback @

  getHtml : ->

  title : -> @source.atom.title
  subtitle : -> @source.atom.subtitle
  author : -> @source.atom.author
  mylistId : -> @source.atom.mylistId
  updatedTime : -> @source.atom.updated
  movies : ->
class NicoQuery.Source.MylistAtom
  constructor : (@xml) ->
    @entry = {}
    for entry in $(@xml).find 'entry'
      e = new NicoQuery.Source.EntryAtom entry
      @entry[e.videoId] = e

    @b = $(@xml)

    @title = @b.find('title').eq(0).text().substring("マイリスト　".length).slice(0, -("‐ニコニコ動画".length))
    @subtitle = @b.find('subtitle').text()
    @mylistId = Number @b.find('link').eq(0).attr('href').split('/')[4]
    @updated = @b.find('updated').eq(0).text()
    @author = @b.find('author name').text()

    delete @b

class NicoQuery.TagSearch
  constructor : (@params={}, @callback) ->
    @page = @params.page || 1
    @searchString = @params.searchString || ''
    @params.sortMethod = 'newness_of_comment'
    @params.orderParam = 'desc'

    connection = new NicoQuery.Connection @uri(),
      success : (browser) =>
        info = new TagSearchAtom browser.window.document.innerHTML
        @callback info

  uri : -> @host() + @path() + '?' + @queryParam()

  host : -> 'http://www.nicovideo.jp/'

  path : -> "tag/#{@searchString}"

  queryParam : ->
    param = []
    param.push pageParam()
    param.push sortParam() if sortParam()?
    param.push orderParam() if orderParam()?
    param.push 'rss=atom'

    param.join '&'

  next : ->
    @page += 1

  prev : ->
    @page -= 1

  pageParam : -> "page=#{@page}"

  sortParam : ->
    switch @params.sortMethod
      when 'newness_of_comment' then null
      when 'view_num' then 'sort=v'
      when 'comment_num' then 'sort=r'
      when 'mylist_num' then 'sort=m'
      when 'published_date' then 'sort=f'
      when 'length' then 'sort=l'

  orderParam : ->
    switch @params.orderParam
      when 'asc' then 'order=a'
      when 'desc' then null
class NicoQuery.Source.TagSearchAtom
  constructor : (@xml) ->
    @entry = {}
    for entry in $(@xml).find 'entry'
      e = new NicoQuery.Source.EntryAtom entry
      @entry[e.videoId] = e

    @b = $(@xml)

    @title = @b.find('title').eq(0).text().substring("マイリスト　".length).slice(0, -("‐ニコニコ動画".length))
    @subtitle = @b.find('subtitle').text()
    @updated = @b.find('updated').eq(0).text()
    @tags = @b .find('title').eq(0).text()
               .substring("タグ ".length)
               .slice(0, -("‐ニコニコ動画".length))
               .split(" ")
    delete @b

module.exports = NicoQuery