_  = require 'underscore'
_.str = require 'underscore.string'
_.mixin _.str.exports()
_.str.include 'Underscore.string', 'string'
$ = require 'jquery'


class GetThumbInfo
  constructor : (@xml) ->
    b = $(@xml).find('thumb')

    @title = b.find('title').text()
    @description = b.find('description').text()
    @thumbnail_url = b.find('thumbnail_url').text()
    @first_retrieve = b.find('first_retrieve').text()
    @length = @.convert_to_sec b.find('length').text()
    @movie_type = b.find('movie_type').text()
    @size_high = Number b.find('size_high').text()
    @size_low = Number b.find('size_low').text()
    @view_counter = Number b.find('view_counter').text()
    @comment_num = Number b.find('comment_num').text()
    @mylist_counter = Number b.find('mylist_counter').text()
    @last_res_body = b.find('last_res_body name').text()
    @watch_url = b.find('watch_url').text()
    @thumb_type = b.find('thumb_type').eq(0).text()
    @embeddable = Number b.find('embeddable').text()
    @no_live_play = Number b.find('no_live_play').text()

    @tags = @.parse_tags()

  parse_tags : ->
    xml_jp = $(@xml).find('tags[domain=jp]')
    xml_tw = $(@xml).find('tags[domain=tw]')

    { 'jp' : @.objectize xml_jp }

  objectize : (xml) ->
    array = []

    xml.find('tag').each (i, e) ->
      e = $(e)
      obj = { string : e.text() }
      category = e.attr('category')
      lock = e.attr('lock')
      _.extend obj, { category : Number category } unless _.isEmpty(category)
      _.extend obj, { lock : Number lock } unless _.isEmpty(lock)

      array.push obj

    return array

  convert_to_sec : (string) ->
    s = string.split(':')
    minute = Number s[0]
    second = Number s[1]
    minute * 60 + second

  convert_to_unix_time : (string) ->
    s = string.match(/\w+/g)
    new Date(s[0], s[1] - 1, s[2], s[3], s[4], s[5], 0) / 1000

module.exports = GetThumbInfo