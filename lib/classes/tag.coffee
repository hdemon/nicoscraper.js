NicoScraper.tag = (keyword, callback) ->
  tag = new NicoScraper.TagSearch keyword
  order == 'continue'
  movies = tag.movies()

  nextMovie = ->
    movies = tag.nextPage().movies() if _.isEmpty movies
    movies.shift()

  while order == 'continue'
    order = callback nextMovie()

