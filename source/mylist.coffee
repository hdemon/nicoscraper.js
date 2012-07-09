class NicoQuery.Mylist
  constructor : (@mylist_id, callback) ->
    @uri = "http://www.nicovideo.jp/mylist/#{@mylist_id}?rss=atom"

    connection = new NicoQuery.Connection @uri,
      success : (browser) =>
        @xml = new NicoQuery.MylistAtom browser.window.document.innerHTML
        callback @

  title : -> @xml.title
  subtitle : -> @xml.subtitle
  author : -> @xml.author
  mylistId : -> @xml.mylist_id
  updatedTime : -> @xml.updated
  movies : ->
