_  = require 'underscore'
_.str = require 'underscore.string'
_.mixin _.str.exports()
_.str.include 'Underscore.string', 'string'

require 'should'
sinon = require 'sinon'
nock = require 'nock'
fs = require 'fs'

NicoQuery = require '../production/nicoquery.js'

describe "about Movie class", ->
  before (done) ->
    data = fs.readFileSync "./test/getthumbinfo_sm17836499.xml"
    fixture = { window : { document : { innerHTML : data.toString 'ascii' }}}

    sinon.stub(NicoQuery, "Connection").yieldsTo "success", fixture
    @mv = new NicoQuery.Movie "sm17836499"

    done()

  after ->
    NicoQuery.Connection.restore()

  describe "when create an instance", ->
    it "has mylist uri string", ->
      # @url.should.match /http¥:¥/¥/www¥.nicovideo¥.jp¥/mylist/

  describe "#getAtom", ->
    before (done) ->
      @mv.getAtom ->
        done()

    it "returns a mylist object", ->
      @mv.videoId().should.equal "sm17836499"
      @mv.title().should.equal "今日もBF3で酒がうまいぜ　その17　ゆっくりできない実況"
      @mv.description().should.equal "深刻な素材不足によりＯＰはなしです、突撃兵はいかんねもうカットしまくりで疲れました･･･コンクエと突撃兵の組み合わせはもうないでしょう使用武器　M16A3　バイポ＋ヘビバレ　M26MAP      Kharg Island（カーグ・アイランド）まいりす→mylist/31380823　　次→sm17860243"
      @mv.thumbnailUrl().should.equal "http://tn-skr4.smilevideo.jp/smile?i=17836499"
      @mv.firstRetrieve().should.equal "2012-05-16T04:12:57+09:00"
      @mv.length().should.equal 648
      @mv.movieType().should.equal "mp4"
      @mv.sizeHigh().should.equal 94520518
      @mv.sizeLow().should.equal 35257133
      @mv.viewCounter().should.equal 15925
      @mv.commentNum().should.equal 297
      @mv.mylistCounter().should.equal 107
      @mv.lastResBody().should.equal "メニュー開けば直るぅ こわいこわいｗｗｗ おつ ｗｗｗｗｗｗｗ バグったｗｗｗ ｗｗｗｗｗ... "
      @mv.watchUrl().should.equal "http://www.nicovideo.jp/watch/sm17836499"
      @mv.thumbType().should.equal "video"
      @mv.embeddable().should.equal 1
      @mv.noLivePlay().should.equal 0
