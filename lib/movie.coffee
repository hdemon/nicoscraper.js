_  = require 'underscore'
_.str = require 'underscore.string'
_.mixin _.str.exports()
_.str.include 'Underscore.string', 'string'

$ = require 'jquery'
Zombie = require 'zombie'


class Movie
  constructor : (string_of_id_or_unixtime) ->
    @.set_type string_of_id_or_unixtime

  set_type : (string_of_id_or_unixtime) ->
    if _(string_of_id_or_unixtime).startsWith 'nm'
      @type = 'Niconico Movie Maker'
    else if _(string_of_id_or_unixtime).startsWith 'sm'
      @type = 'Smile Video'
    else
      @type = 'unknown'


module.exports = Movie
m = new Movie 'sm17683648'
console.log m
