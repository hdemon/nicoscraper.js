class NicoScraper.TagSearchAtom extends Module
  @extend NicoScraper.Utility

  constructor: (@keyword, @options={}) ->
    @_cache = {}

    @options =
      page: 1
      sort:'newness_of_comment'
      order:'desc'

    @page = @options.page

  next : ->
    @page += 1
    @_cache = {}

  prev : ->
    @page -= 1
    @_cache = {}

  uri : -> "http://www.nicovideo.jp/tag/#{@keyword}?" + @_queryParam()

  body: ->
    if @_cache.body?
      @_cache.body
    else
      @scraped = true
      @_cache.body = $(NicoScraper.Connection @uri())

  movies: ->
    @_cache.movies ?= @_entries()


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
    @_cache.content ?= @body.find 'content'

  title: ->
    @_cache.title ?= @body.find('title').text()

  videoId: ->
    @_cache.videoId ?= @body.find('link').attr('href').split('/')[4]

  timelikeId: ->
    @_cache.timelikeId ?=
      Number @body.find('id').text()
                  .split(',')[1].split(':')[1].split('/')[2]
  published: ->
    @_cache.published ?= @body.find('published').text()

  updated: ->
    @_cache.updated ?= @body.find('updated').text()

  thumbnailUrl: ->
    @_cache.thumbnailUrl ?= @content().find('img').attr('src')

  description: ->
    @_cache.description ?= @content().find('.nico-description').text()

  length: ->
    @_cache.length ?= @_cache.convertToSec @content().find('.nico-info-length').text()

  infoDate: ->
    @_cache.infoDate ?= @_cache.convertToUnixTime @content().find('.nico-info-date').text()

