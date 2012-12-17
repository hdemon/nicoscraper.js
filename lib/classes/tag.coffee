NicoScraper.tag = (keyword, options) ->
  tag = new NicoScraper.TagSearch keyword, options
  order = 'continue'
  movies = tag.movies()

  nextMovie = ->
    movies = tag.nextPage().movies() if _.isEmpty movies
    movies.shift()

  while order == 'continue' && tag.isContinued()
    order = options.each movie if (movie = nextMovie())?

  options.finished()
