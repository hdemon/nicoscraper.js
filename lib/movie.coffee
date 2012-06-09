_  = require 'underscore'
_.str = require 'underscore.string'
_.mixin _.str.exports()
_.str.include 'Underscore.string', 'string'

$ = require 'jquery'
Zombie = require 'zombie'


class Movie
  constructor : (@provisional_id) ->
    @type = get_type()

  get_type : ->
    switch _(@provisional_id)
      when startsWith 'nm'
        'Niconico Movie Maker'
      when startsWith 'sm'
        'Smile Video'
      else
        'unknown'

module.exports = Movie