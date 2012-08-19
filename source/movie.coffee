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
    @provisional_id or
    @source.mylistAtom.videoId

  threadId : ->
    @source.mylistAtom.threadId

  title : ->
    @source.getThumbInfo.title or
    @source.mylistAtom.title

  description : ->
    @source.getThumbInfo.description or
    @source.mylistAtom.description

  thumbnailUrl : ->
    @source.getThumbInfo.thumbnailUrl or
    @source.mylistAtom.thumbnailUrl

  firstRetrieve : ->
    @source.getThumbInfo.firstRetrieve

  published : ->
    @source.getThumbInfo.published

  updated : ->
    @source.getThumbInfo.updated

  infoDate : ->
    @source.getThumbInfo.infoDate

  length : ->
    @source.getThumbInfo.length or
    @source.mylistAtom.length

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

