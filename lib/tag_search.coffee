_  = require 'underscore'
_.str = require 'underscore.string'
_.mixin _.str.exports()
_.str.include 'Underscore.string', 'string'
$ = require 'jquery'
Connection = require '../lib/connection'
TagSearchAtom = require '../lib/tag_search_atom'

class TagSearch
  constructor : (@params={}, @callback) ->
    @page = @params.page || 1
    @search_string = @params.search_string || ''
    @params.sort_method = 'newness_of_comment'
    @params.order_param = 'desc'

    connection = new Connection @uri(),
      success : (browser) =>
        info = new TagSearchAtom browser.window.document.innerHTML
        @callback(info)

  uri : -> @host() + @path() + '?' + @param()

  host : -> 'http://www.nicovideo.jp/'

  path : -> "tag/#{@search_string}"

  param : ->
    param = []
    param.push page_param()
    param.push sort_param() if sort_param()?
    param.push order_param() if order_param()?
    param.push 'rss=atom'

    param.join('&')

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

  next : ->
    @page += 1

  prev : ->
    @page -= 1


module.exports = TagSearch