_  = require 'underscore'
_.str = require 'underscore.string'
_.mixin _.str.exports()
_.str.include 'Underscore.string', 'string'

require 'should'
sinon = require 'sinon'
fs = require 'fs'

global.Mylist = require "#{__dirname}/../lib/mylist.coffee"


describe "about Mylist class", ->
  describe "when create an instance with mylist id", ->
    before (done) ->
      data = fs.readFileSync "./test/mylist_26121590.xml"
      fixture = { window : { document : { innerHTML : data.toString 'ascii' }}}

      sinon.stub(global, "Connection").yieldsTo "success", fixture

      new Mylist 26121590, (mylist_obj) =>
        @ml = mylist_obj
        done()

    it "returns a mylist object", ->
      @ml.title().should.equal("part1マイリスト")
      @ml.subtitle().should.equal("")
      @ml.author().should.equal("みつひで2")
      @ml.mylistId().should.equal(26121590)
      @ml.updatedTime().should.equal("2012-06-09T20:58:32+09:00")
      # @ml.movies().should.equal()
