_  = require 'underscore'
_.str = require 'underscore.string'
_.mixin _.str.exports()
_.str.include 'Underscore.string', 'string'

require 'should'
sinon = require 'sinon'
nock = require 'nock'
fs = require 'fs'

NicoQuery = require '../production/nicoquery.js'

describe "about Mylist class", ->
  before (done) ->
    data = fs.readFileSync "./test/mylist_26121590.xml"
    fixture = { window : { document : { innerHTML : data.toString 'ascii' }}}

    sinon.stub(NicoQuery, "Connection").yieldsTo "success", fixture
    @ml = new NicoQuery.Mylist 26121590

    done()

  after ->
    NicoQuery.Connection.restore()

  describe "when create an instance with mylist id", ->
    it "has mylist uri string", ->
      # @url.should.match /http¥:¥/¥/www¥.nicovideo¥.jp¥/mylist/

  describe "#getAtom", ->
    before (done) ->
      @ml.getAtom ->
        done()

    it "returns a mylist object", ->
      @ml.title().should.equal("part1マイリスト")
      @ml.subtitle().should.equal("it is fixture")
      @ml.author().should.equal("みつひで")
      @ml.mylistId().should.equal(26121590)
      @ml.updatedTime().should.equal("2012-06-09T20:58:32+09:00")
      # @ml.movies().should.equal()
