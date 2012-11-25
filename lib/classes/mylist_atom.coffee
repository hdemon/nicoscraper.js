class NicoScraper.MylistAtom extends Module
  @extend NicoScraper.Utility

  constructor: (@id, @scraped=false) ->

  body: ->
    if @_body?
      @_body
    else
      @scraped = true
      @_body = $(NicoScraper.Connection "http://www.nicovideo.jp/mylist/#{@id}?rss=atom")

  title: ->
    @_title ?=
      @body().find('title').eq(0)
        .text()
        .substring("マイリスト　".length)
        .slice(0, -("‐ニコニコ動画".length))

  subtitle: ->
    @_subtitle ?=
      @body().find('subtitle').text()

  mylistId: ->
    @_mylistId ?=
      Number @body()
        .find('link').eq(0)
        .attr('href').split('/')[4]

  updated: ->
    @_updated ?= @body().find('updated').eq(0).text()

  author: ->
    @_author ?= @body().find('author name').text()

  movies: ->
    @_movies ?= @_entries()

  _entries: ->
    entries = {}

    for entry in @body().find 'entry'
      _entry = new NicoScraper.MylistAtom.Entry $(entry)
      entries[_entry.videoId()] = _entry

    entries


class NicoScraper.MylistAtom.Entry extends Module
  @extend NicoScraper.Utility

  constructor: (@body) ->

  content: ->
    @_content ?= @body.find 'content'

  title: ->
    @_title ?= @body.find('title').text()

  videoId: ->
    @_videoId ?= @body.find('link').attr('href').split('/')[4]

  timelikeId: ->
    @_timelikeId ?=
      Number @body.find('id').text()
                  .split(',')[1].split(':')[1].split('/')[2]
  published: ->
    @_published ?= @body.find('published').text()

  updated: ->
    @_updated ?= @body.find('updated').text()

  thumbnailUrl: ->
    @_thumbnailUrl ?= @content().find('img').attr('src')

  description: ->
    @_description ?= @content().find('.nico-description').text()

  length: ->
    @_length ?= @_convertToSec @content().find('.nico-info-length').text()

  infoDate: ->
    @_infoDate ?= @_convertToUnixTime @content().find('.nico-info-date').text()

