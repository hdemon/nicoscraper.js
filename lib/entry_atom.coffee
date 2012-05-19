_  = require 'underscore'
_.str = require 'underscore.string'
_.mixin _.str.exports()
_.str.include 'Underscore.string', 'string'
$ = require 'jquery'


class EntryAtom
  constructor : (@body) ->
    @b = $(@body)
    @c = @b.find('content')

    @.get_all_info()

    @b = @c = null

  get_all_info : ->
    @.get_title()
    @.get_video_id()
    @.get_timelike_id()
    @.get_published_time()
    @.get_updated_time()
    @.get_thumbnail_url()
    @.get_description()
    @.get_length()
    @.get_info_date()

  get_title : ->
    @title = @b.find('title').text()

  get_video_id : ->
    @video_id = @b.find('link').attr('href').split('/')[4]

  get_timelike_id : ->
    @timelike_id = Number @b.find('id').text().split(',')[1].split(':')[1].split('/')[2]

  get_published_time : ->
    @published = @b.find('published').text()

  get_updated_time : ->
    @updated = @b.find('updated').text()

  get_thumbnail_url : ->
    @thumbnail_url = @c.find('img').attr('src')

  get_description : ->
    @description = @c.find('.nico-description').text()

  get_length : ->
    @length = @.convert_to_sec @c.find('.nico-info-length').text()

  get_info_date : ->
    @info_date = @.convert_to_unix_time @c.find('.nico-info-date').text()

  convert_to_sec : (string) ->
    s = string.split(':')
    minute = Number s[0]
    second = Number s[1]
    minute * 60 + second

  convert_to_unix_time : (string) ->
    s = string.match(/\w+/g)
    new Date(s[0], s[1] - 1, s[2], s[3], s[4], s[5], 0) / 1000

module.exports = EntryAtom