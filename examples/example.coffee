nicoscraper = require '../production/nicoscraper.js'

movie = new nicoscraper.Movie 'sm9'
mylist = new nicoscraper.Mylist '33048313'
tag = new nicoscraper.TagSearch 'ゆっくり'


console.log tag.movie("sm11622191").title()

console.log mylist.title()
console.log mylist.subTitle()
console.log mylist.mylistId()
console.log mylist.updatedTime()
console.log mylist.movies()
console.log mylist.movie("sm19374671").title()

console.log movie.title()
console.log movie.title()
console.log movie.videoId()
console.log movie.description()
console.log movie.published()
console.log movie.tags()
