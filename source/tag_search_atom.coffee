class NicoQuery.TagSearchAtom extends NicoQuery.MylistAtom
  getAllInfo : ->
    @tags()
    @updatedTime()

  tags : ->
    @tags = @b .find('title').eq(0).text()
               .substring("タグ ".length)
               .slice(0, -("‐ニコニコ動画".length))
               .split(" ")
