class NicoScraper.Mylist
  constructor : (@mylist_id) ->
    @uri = "http://www.nicovideo.jp/mylist/#{@mylist_id}"

    @source =
      atom : {}
      html : {}

  getAtom : (callback) ->
    connection = new NicoScraper.Connection @uri + "?rss=atom",
      success : (browser) =>
        @source.atom = new NicoScraper.Source.MylistAtom browser.window.document.innerHTML
        console.log "callback"
        callback @

  getHtml : ->

  title : -> @source.atom.title
  subtitle : -> @source.atom.subtitle
  author : -> @source.atom.author
  mylistId : -> @source.atom.mylistId
  updatedTime : -> @source.atom.updated
  movies : ->
