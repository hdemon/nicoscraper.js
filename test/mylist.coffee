_  = require 'underscore'
_.str = require 'underscore.string'
_.mixin _.str.exports()
_.str.include 'Underscore.string', 'string'
require 'should'
Mylist = require '../lib/mylist.coffee'


describe "about Mylist class", ->
  describe "when create an instance with mylist id", ->
    before (done) ->
      new Mylist(26121590, (mylist_obj) =>
        @ml = mylist_obj
        done()
      )

    it "returns a mylist object", ->
      @ml.title().should.equal("part1マイリスト")