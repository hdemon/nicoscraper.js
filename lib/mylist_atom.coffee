_  = require 'underscore'
_.str = require 'underscore.string'
_.mixin _.str.exports()
_.str.include 'Underscore.string', 'string'
$ = require 'jquery'


class MylistAtom
  constructor : (@xml) ->
    @entry = {}
    for entry in $(@xml).find('entry')
      e = new MylistEntry(entry)
      @entry[e.video_id] = e

class MylistEntry
  constructor : (@body) ->
    b = $(@body)
    @title = b.find('title').text()
    @video_id = b.find('link').attr('href').split('/')[4]
    @timelike_id = Number(b.find('id').text().split(',')[1].split(':')[1].split('/')[2])
    @published = b.find('published').text()
    @updated = b.find('updated').text()

    c = b.find('content')
    @thumbnail_url = c.find('img').attr('src')
    @description = c.find('.nico-description').text()
    @length = @.convert_to_sec c.find('.nico-info-length').text()
    @info_date = @.convert_to_unix_time c.find('.nico-info-date').text()

  convert_to_sec : (string) ->
    s = string.split(':')
    minute = Number s[0]
    second = Number s[1]
    minute * 60 + second

  convert_to_unix_time : (string) ->
    s = string.match(/\w+/g)
    new Date(s[0], s[1] - 1, s[2], s[3], s[4], s[5], 0) / 1000

module.exports = MylistAtom