_  = require 'underscore'
_.str = require 'underscore.string'
_.mixin _.str.exports()
_.str.include 'Underscore.string', 'string'

require 'should'
sinon = require 'sinon'
nock = require 'nock'

NicoScraper = require '../production/nicoquery.js'


xml = '''
<?xml version="1.0" encoding="utf-8"?>
<feed xmlns="http://www.w3.org/2005/Atom" xml:lang="ja"></feed>
'''

describe "About Connection class", ->
  describe "when create an instance with a normal url", ->
    before ->
      @nico =
        nock('http://www.nicovideo.jp')
          .get('/watch/sm123')
          .reply(200, xml)

    it "has a response body", (done) ->
      new NicoScraper.Connection 'http://www.nicovideo.jp/watch/sm123',
        success : (browser) ->
          browser.response[0].should.equal 200

          done()
