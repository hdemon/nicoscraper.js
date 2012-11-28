class NicoScraper.TagSearch
  constructor: (@keyword) ->

  movies: ->
    movies = []

    for videoId, movie of @_source("movies")
      movies.push new NicoScraper.Movie videoId, movie

    movies

  movie: (id) ->
    @movies()[id]

  nextPage : ->
    @__tagSearchAtom.next()
    @

  prevPage : ->
    @__tagSearchAtom.prev()
    @

  _source: (attr) ->
    @_tagSearchAtom()[attr]() if @_tagSearchAtom().scraped and @_tagSearchAtom()[attr]?
    @_tagSearch()[attr]() if @_tagSearch().scraped and @_tagSearch()[attr]?

    @_tagSearchAtom()[attr]() if @_tagSearchAtom()[attr]?
    @_tagSearch()[attr]() if @_tagSearch()[attr]?


  _tagSearchAtom: =>
    @__tagSearchAtom ?= new NicoScraper.TagSearchAtom @keyword, {page: @_page}

  _tagSearch: =>
    @__tagSearchAtom ?= new NicoScraper.TagSearchAtom @keyword, {page: @_page}
