_  = require 'underscore'
_.str = require 'underscore.string'
_.mixin _.str.exports()
_.str.include 'Underscore.string', 'string'

$ = require 'jquery'

Connection = require '../lib/connection'
MylistAtom = require '../lib/mylist_atom'
# Connection = require 'connection'


$ml = (mylist_id) ->
  new Mylist mylist_id


class Mylist
  constructor : (@mylist_id, callback) ->
    @uri = "http://www.nicovideo.jp/mylist/#{@mylist_id}?rss=atom"

    connection = new Connection @uri,
      success : (browser) =>
        @xml = new MylistAtom browser.window.document.innerHTML
        callback @


  title : ->
    @xml.title

module.exports = Mylist
