nicoscraper = require '../production/nicoscraper.js'

movie = new nicoscraper.Movie 'sm9'
mylist = new nicoscraper.Mylist '33048313'
tag = new nicoscraper.TagSearch 'ゆっくり'


# console.log tag.movies()
# console.log tag.movie("sm11622191").title()
# tag.next()
# console.log tag.movies()

# console.log mylist.title()
# console.log mylist.subTitle()
# console.log mylist.mylistId()
# console.log mylist.updatedTime()
# console.log mylist.movies()
# console.log mylist.movie("sm19374671").title()

# console.log movie.title()
# console.log movie.videoId()
# console.log movie.description()
# # console.log movie.published()
# console.log movie.tags()

# nicoscraper.tag 'ABC',
nicoscraper.tag 'ゆっくり実況プレイpart1リンク',
  page: 1
  sort: 'published_date'
  order: 'desc'
  each: (movie) ->
    console.log movie
    console.log movie.title()
    'continue'
  finished: ->
    console.log 'finished'
