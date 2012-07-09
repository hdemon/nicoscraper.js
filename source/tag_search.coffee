class NicoQuery.TagSearch
  constructor : (@params={}, @callback) ->
    @page = @params.page || 1
    @search_string = @params.search_string || ''
    @params.sort_method = 'newness_of_comment'
    @params.order_param = 'desc'

    connection = new NicoQuery.Connection @uri(),
      success : (browser) =>
        info = new TagSearchAtom browser.window.document.innerHTML
        @callback info

  uri : -> @host() + @path() + '?' + @query_param()

  host : -> 'http://www.nicovideo.jp/'

  path : -> "tag/#{@search_string}"

  query_param : ->
    param = []
    param.push page_param()
    param.push sort_param() if sort_param()?
    param.push order_param() if order_param()?
    param.push 'rss=atom'

    param.join '&'

  next : ->
    @page += 1

  prev : ->
    @page -= 1

  _page_param : -> "page=#{@page}"

  _sort_param : ->
    switch @params.sort_method
      when 'newness_of_comment' then null
      when 'view_num' then 'sort=v'
      when 'comment_num' then 'sort=r'
      when 'mylist_num' then 'sort=m'
      when 'published_date' then 'sort=f'
      when 'length' then 'sort=l'

  _order_param : ->
    switch @params.order_param
      when 'asc' then 'order=a'
      when 'desc' then null
