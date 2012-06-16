_  = require 'underscore'
_.str = require 'underscore.string'
_.mixin _.str.exports()
_.str.include 'Underscore.string', 'string'
$ = require 'jquery'
MylistAtom = require '../source/mylist_atom'


class TagSearchAtom extends MylistAtom
  get_all_info : ->
    @get_tags()
    @get_updated_time()

  get_tags : ->
    @tags = @b .find('title').eq(0).text()
               .substring("タグ ".length)
               .slice(0, -("‐ニコニコ動画".length))
               .split(" ")

module.exports = TagSearchAtom