class NicoQuery.Movie
  constructor : (@provisional_id) ->
    @type = @getType()
    @source =
      getThumbInfo: {}
      mylistAtom: {}
      mylistHtml: {}
      html: {}

  getAtom : (callback) ->
    connection = new NicoQuery.Connection @uri + "?rss=atom",
      success : (browser) =>
        @source.getThumbInfo = new NicoQuery.Source.GetThumbInfo browser.window.document.innerHTML
        console.log "callback"
        callback @

  getType : ->
    switch _.startsWith @provisional_id
      when 'nm'
        'Niconico Movie Maker'
      when 'sm'
        'Smile Video'
      else
        'unknown'

  videoId : ->
    @provisional_id

  title : ->
    @source.getThumbInfo.title


  description : ->
    @source.getThumbInfo.description

  thumbnailUrl : ->
    @source.getThumbInfo.thumbnailUrl

  firstRetrieve : ->
    @source.getThumbInfo.firstRetrieve

  length : ->
    @source.getThumbInfo.length

  movieType : ->
    @source.getThumbInfo.movieType

  sizeHigh : ->
    @source.getThumbInfo.sizeHigh

  sizeLow : ->
    @source.getThumbInfo.sizeLow

  viewCounter : ->
    @source.getThumbInfo.viewCounter

  commentNum : ->
    @source.getThumbInfo.commentNum

  mylistCounter : ->
    @source.getThumbInfo.mylistCounter

  lastResBody : ->
    @source.getThumbInfo.lastResBody

  watchUrl : ->
    @source.getThumbInfo.watchUrl

  thumbType : ->
    @source.getThumbInfo.thumbType

  embeddable : ->
    @source.getThumbInfo.embeddable

  noLivePlay : ->
    @source.getThumbInfo.noLivePlay

