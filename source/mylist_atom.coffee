class NicoQuery.MylistAtom
  constructor : (@xml) ->
    @entry = {}
    for entry in $(@xml).find 'entry'
      e = new NicoQuery.EntryAtom entry
      @entry[e.video_id] = e

    @b = $(@xml)

    @title = @b.find('title').eq(0).text().substring("マイリスト　".length).slice(0, -("‐ニコニコ動画".length))
    @subtitle = @b.find('subtitle').text()
    @mylistId = Number @b.find('link').eq(0).attr('href').split('/')[4]
    @updated = @b.find('updated').eq(0).text()
    @author = @b.find('author name').text()

    delete @b

