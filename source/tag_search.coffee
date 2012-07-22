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
