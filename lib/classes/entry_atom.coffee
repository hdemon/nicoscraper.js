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

