_  = require 'underscore'
_.str = require 'underscore.string'
_.mixin _.str.exports()
_.str.include 'Underscore.string', 'string'

$ = require 'jquery'
Zombie = require 'zombie'


class Mylist
  constructor : (@mylist_id) ->
