class NicoQuery.Source.EntryAtom extends Module
  @extend NicoQuery.Utility

  constructor : (@body) ->
    @b = $(@body)
    @c = @b.find 'content'

    @getAllInfo()

    @b = @c = null

  getAllInfo : ->
    @title()
    @videoId()
    @timelikeId()
    @publishedTime()
    @updatedTime()
    @thumbnailUrl()
    @description()
    @length()
    @infoDate()

  title : ->
    @title = @b.find('title').text()

  videoId : ->
    @videoId = @b.find('link').attr('href').split('/')[4]

  timelikeId : ->
    @timelikeId = Number @b.find('id').text().split(',')[1].split(':')[1].split('/')[2]

  publishedTime : ->
    @published = @b.find('published').text()

  updatedTime : ->
    @updated = @b.find('updated').text()

  thumbnailUrl : ->
    @thumbnailUrl = @c.find('img').attr('src')

  description : ->
    @description = @c.find('.nico-description').text()

  length : ->
    @length = @_convert_to_sec @c.find('.nico-info-length').text()

  infoDate : ->
    @infoDate = @_convert_to_unix_time @c.find('.nico-info-date').text()

module.exports = NicoQuery.EntryAtom
