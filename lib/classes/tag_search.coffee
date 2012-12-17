class NicoScraper.TagSearch
  constructor: (@keyword, @options) ->

  movies: ->
    @_movies ?= (=>
      movies = []

      for videoId, movie of @_source("movies")
        movies.push new NicoScraper.Movie videoId, movie

      movies
    )()

  movie: (id) ->
    @movies()[id]

  nextPage : ->
    @_tagSearchAtom().next()
    delete @_movies
    @

  prevPage : ->
    @_tagSearchAtom().prev()
    delete @_movies
    @

  isContinued: ->
    @_tagSearchAtom().size() > 0

  _source: (attr) ->
    @_tagSearchAtom()[attr]() if @_tagSearchAtom().scraped and @_tagSearchAtom()[attr]?
    @_tagSearch()[attr]() if @_tagSearch().scraped and @_tagSearch()[attr]?

    @_tagSearchAtom()[attr]() if @_tagSearchAtom()[attr]?
    @_tagSearch()[attr]() if @_tagSearch()[attr]?


  _tagSearchAtom: =>
    @__tagSearchAtom ?= new NicoScraper.TagSearchAtom @keyword, @options

  _tagSearch: =>
    @__tagSearchAtom ?= new NicoScraper.TagSearchAtom @keyword, @options
