class NicoQuery.Source.GetThumbInfo extends Module
  @extend NicoQuery.Utility

  constructor : (@xml) ->
    b = $(@xml).find('thumb')

    @title = b.find('title').text()
    @description = b.find('description').text()
    @thumbnail_url = b.find('thumbnail_url').text()
    @first_retrieve = b.find('first_retrieve').text()
    @length = @_convert_to_sec b.find('length').text()
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

    @tags = @_parse_tags()

  _parse_tags : ->
    xml_jp = $(@xml).find('tags[domain=jp]')
    xml_tw = $(@xml).find('tags[domain=tw]')

    { 'jp' : @_objectize xml_jp }

  _objectize : (xml) ->
    array = []

    xml.find('tag').each (i, e) ->
      e = $(e)
      obj = { string : e.text() }
      category = e.attr 'category'
      lock = e.attr 'lock'
      _.extend obj, { category : Number category } unless _.isEmpty category
      _.extend obj, { lock : Number lock } unless _.isEmpty lock

      array.push obj

    return array
