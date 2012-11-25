class NicoScraper.TagSearch
  constructor: (@keyword) ->

  # keyword: -> @_source "keyword"

  movies: ->
    movies = {}

    console.log @_source("movies")
    for videoId, movie of @_source("movies")
      movies[videoId] = new NicoScraper.Movie videoId, movie

    movies

  movie: (id) ->
    @movies()[id]


  _source: (attr) ->
    @_tagSearchAtom()[attr]() if @_tagSearchAtom().scraped and @_tagSearchAtom()[attr]?
    @_tagSearch()[attr]() if @_tagSearch().scraped and @_tagSearch()[attr]?

    @_tagSearchAtom()[attr]() if @_tagSearchAtom()[attr]?
    @_tagSearch()[attr]() if @_tagSearch()[attr]?


  _tagSearchAtom: =>
    @__tagSearchAtom ?= new NicoScraper.TagSearchAtom @keyword

  _tagSearch: =>
    @__tagSearchAtom ?= new NicoScraper.TagSearchAtom @keyword
