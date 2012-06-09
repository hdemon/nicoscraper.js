_  = require 'underscore'
_.str = require 'underscore.string'
_.mixin _.str.exports()
_.str.include 'Underscore.string', 'string'

$ = require 'jquery'

EntryAtom = require '../lib/entry_atom'


class MylistAtom
  constructor : (@xml) ->
    @entry = {}
    for entry in $(@xml).find 'entry'
      e = new EntryAtom entry
      @entry[e.video_id] = e

    @b = $(@xml)
    @get_all_info()
    delete @b

  get_all_info : ->
    @get_title()
    @get_subtitle()
    @get_mylist_id()
    @get_updated_time()
    @get_author()

  get_title : ->
    @title = @b.find('title').eq(0).text().substring("マイリスト　".length).slice(0, -("‐ニコニコ動画".length))

  get_subtitle : ->
    @subtitle = @b.find('subtitle').text()

  get_mylist_id : ->
    @mylist_id = Number @b.find('link').eq(0).attr('href').split('/')[4]

  get_updated_time : ->
    @updated = @b.find('updated').eq(0).text()

  get_author : ->
    @author = @b.find('author name').text()


module.exports = MylistAtom