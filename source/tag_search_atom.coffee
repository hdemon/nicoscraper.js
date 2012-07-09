class NicoQuery.TagSearchAtom extends NicoQuery.MylistAtom
  get_all_info : ->
    @get_tags()
    @get_updated_time()

  get_tags : ->
    @tags = @b .find('title').eq(0).text()
               .substring("タグ ".length)
               .slice(0, -("‐ニコニコ動画".length))
               .split(" ")
