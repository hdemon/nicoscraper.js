class NicoQuery.TagSearchAtom
  constructor : (@xml) ->
    @entry = {}
    for entry in $(@xml).find 'entry'
      e = new NicoQuery.EntryAtom entry
      @entry[e.video_id] = e

    @b = $(@xml)

    @title = @b.find('title').eq(0).text().substring("マイリスト　".length).slice(0, -("‐ニコニコ動画".length))
    @subtitle = @b.find('subtitle').text()
    @updated = @b.find('updated').eq(0).text()
    @tags = @b .find('title').eq(0).text()
               .substring("タグ ".length)
               .slice(0, -("‐ニコニコ動画".length))
               .split(" ")
    delete @b
