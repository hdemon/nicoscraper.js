require 'should'
sinon = require 'sinon'
nock = require 'nock'

TagSearch = require '../source/tag_search.coffee'

xml = '''
<?xml version="1.0" encoding="utf-8"?>
<feed xmlns="http://www.w3.org/2005/Atom" xml:lang="ja"></feed>
'''

describe "About TagSearch class", ->
  describe "when create an instance with a normal url", ->
    it "has a response body", (done) ->
      # new TagSearch 'ゆっくり実況プレイpart1リンク', (i) ->
      done()