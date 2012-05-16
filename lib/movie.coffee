_  = require 'underscore'
_.str = require 'underscore.string'
_.mixin _.str.exports()
_.str.include 'Underscore.string', 'string'

$ = require 'jquery'
Zombie = require 'zombie'


class Movie
  constructor : (string_of_id_or_unixtime) ->