  # constructor : (@xml) ->
  #   @entry = {}
  #   for entry in $(@xml).find 'entry'
  #     e = new NicoScraper.Source.EntryAtom entry
  #     @entry[e.videoId] = e

class NicoScraper.mylistAtom extends Module
  @extend NicoScraper.Utility

  constructor: (@id, @scraped=false) ->

  body: ->
    if @_body?
      @_body
    else
      @scraped = true
      @_body = NicoScraper.Connection "http://www.nicovideo.jp/mylist/#{@id}?rss=atom"

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
