class NicoScraper.TagSearchAtom extends Module
  @extend NicoScraper.Utility

  constructor: (@keyword, @options={page:1, sort:'newness_of_comment', order:'desc'}) ->
    @page = @options.page

  next : ->
    @page += 1

  prev : ->
    @page -= 1

  uri : -> "http://www.nicovideo.jp/tag/#{@keyword}?" + @_queryParam()

  body: ->
    if @_body?
      @_body
    else
      @scraped = true
      @_body = $(NicoScraper.Connection @uri())

  movies: ->
    @_movies ?= @_entries()


  _queryParam : ->
    param = []
    param.push @_pageParam()
    param.push @_sortParam() if @_sortParam()?
    param.push @_orderParam() if @_orderParam()?
    param.push 'rss=atom'

    param.join '&'

  _pageParam : -> "page=#{@page}"

  _sortParam : ->
    switch @options.sort
      when 'newness_of_comment' then null
      when 'view_num' then 'sort=v'
      when 'comment_num' then 'sort=r'
      when 'mylist_num' then 'sort=m'
      when 'published_date' then 'sort=f'
      when 'length' then 'sort=l'

  _orderParam : ->
    switch @options.order
      when 'asc' then 'order=a'
      when 'desc' then null

  _entries: ->
    entries = {}

    for entry in @body().find 'entry'
      _entry = new NicoScraper.MylistAtom.Entry $(entry)
      entries[_entry.videoId()] = _entry

    entries


class NicoScraper.TagSearchAtom.Entry extends Module
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

