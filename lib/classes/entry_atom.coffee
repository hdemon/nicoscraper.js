class NicoScraper.Source.EntryAtom extends Module
  @extend NicoScraper.Utility

  constructor : (@body) ->
    @b = $(@body)
    @c = @b.find 'content'

    @title = @b.find('title').text()
    @videoId = @b.find('link').attr('href').split('/')[4]
    @timelikeId = Number @b.find('id').text().split(',')[1].split(':')[1].split('/')[2]
    @published = @b.find('published').text()
    @updated = @b.find('updated').text()
    @thumbnailUrl = @c.find('img').attr('src')
    @description = @c.find('.nico-description').text()
    @length = @_convertToSec @c.find('.nico-info-length').text()
    @infoDate = @_convertToUnixTime @c.find('.nico-info-date').text()

module.exports = NicoScraper.EntryAtom
