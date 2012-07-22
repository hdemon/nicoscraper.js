class NicoQuery.Source.GetThumbInfo extends Module
  @extend NicoQuery.Utility

  constructor : (@xml) ->
    b = $(@xml).find('thumb')

    @title = b.find('title').text()
    @description = b.find('description').text()
    @thumbnailUrl = b.find('thumbnail_url').text()
    @firstRetrieve = b.find('first_retrieve').text()
    @length = @_convert_to_sec b.find('length').text()
    @movieType = b.find('movie_type').text()
    @sizeHigh = Number b.find('size_high').text()
    @sizeLow = Number b.find('size_low').text()
    @viewCounter = Number b.find('view_counter').text()
    @commentNum = Number b.find('comment_num').text()
    @mylistCounter = Number b.find('mylist_counter').text()
    @lastResBody = b.find('last_res_body').text()
    @watchUrl = b.find('watch_url').text()
    @thumbType = b.find('thumb_type').eq(0).text()
    @embeddable = Number b.find('embeddable').text()
    @noLivePlay = Number b.find('no_live_play').text()

    @tags = @_parseTags()

  _parseTags : ->
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
