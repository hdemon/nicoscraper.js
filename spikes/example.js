nicoscraper = require '../production/nicoscraper.js'

movie = new nicoscraper.movie 'sm4'
movie.getAtom()
