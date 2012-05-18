_  = require 'underscore'
_.str = require 'underscore.string'
_.mixin _.str.exports()
_.str.include 'Underscore.string', 'string'

$ = require 'jquery'
Zombie = require 'zombie'


class Mylist
  constructor : (@mylist_id) ->

  get : (@callback = ->) ->
    @callback.success ?= ->
    @callback.failed ?= ->      

    zombie = new Zombie
    zombie.runScripts = false

    @uri = "http://www.nicovideo.jp/mylist/#{@mylist_id}?rss=atom"
    console.log @uri
    zombie.visit @uri, (error, browser, status) =>
      @doc = $(browser.window.document)
      @status = status
      @error = error

      if @status == 200
        get_all()
        @callback.success @doc
      else
        @callback.failed(this, @error, @status, @doc)

  get_all : ->
    get_title()


module.exports = Mylist
m = new Mylist '25729382'
m.get
  success : ->
    console.log 'success'

console.log m
