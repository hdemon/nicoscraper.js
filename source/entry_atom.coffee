class NicoQuery.Source.EntryAtom extends Module
  @extend NicoQuery.Utility

  constructor : (@body) ->
    @b = $(@body)
    @c = @b.find 'content'

    @get_all_info()

    @b = @c = null

  get_all_info : ->
    @title()
    @video_id()
    @timelike_id()
    @published_time()
    @updated_time()
    @thumbnail_url()
    @description()
    @length()
    @info_date()

  title : ->
    @title = @b.find('title').text()

  video_id : ->
    @video_id = @b.find('link').attr('href').split('/')[4]

  timelike_id : ->
    @timelike_id = Number @b.find('id').text().split(',')[1].split(':')[1].split('/')[2]

  published_time : ->
    @published = @b.find('published').text()

  updated_time : ->
    @updated = @b.find('updated').text()

  thumbnail_url : ->
    @thumbnail_url = @c.find('img').attr('src')

  description : ->
    @description = @c.find('.nico-description').text()

  length : ->
    @length = @_convert_to_sec @c.find('.nico-info-length').text()

  info_date : ->
    @info_date = @_convert_to_unix_time @c.find('.nico-info-date').text()

module.exports = NicoQuery.EntryAtom
