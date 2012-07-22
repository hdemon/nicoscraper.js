_  = require 'underscore'
_.str = require 'underscore.string'
_.mixin _.str.exports()
_.str.include 'Underscore.string', 'string'

require 'should'
sinon = require 'sinon'
nock = require 'nock'

NicoQuery = require '../production/nicoquery.js'


xml = '''
<nicovideo_thumb_response status="ok">
  <thumb>
  <video_id>sm8481759</video_id>
    <title>【Oblivion】おっさんの大冒険１（ゆっくり実況）</title>
    <description>おっさんの生き様をとくとごらんあれ！このミリオンをいつまでも大切にしたい。そう、いつまでも・・・。おっさんがここまでこれたのも、みなさまのおかげですｍ（＿＿）ｂ次回：sm8506034　マイリス：mylist/15196568【重要】この動画ではPC版Oblivionでしか表現できないシーンが含まれます。このゲームにご興味のある方はご注意ください。</description>
    <thumbnail_url>http://tn-skr4.smilevideo.jp/smile?i=8481759</thumbnail_url>
    <first_retrieve>2009-10-11T14:15:35+09:00</first_retrieve>
    <length>12:28</length>
    <movie_type>mp4</movie_type>
    <size_high>57024573</size_high>
    <size_low>40574829</size_low>
    <view_counter>1765214</view_counter>
    <comment_num>66152</comment_num>
    <mylist_counter>39026</mylist_counter>
    <last_res_body>劣化劣化うるせえな一 そんなにオブリがいい</last_res_body>
    <watch_url>http://www.nicovideo.jp/watch/sm8481759</watch_url>
    <thumb_type>video</thumb_type>
    <embeddable>1</embeddable>
    <no_live_play>0</no_live_play>
    <tags domain="jp">
      <tag category="1" lock="1">ゲーム</tag>
      <tag>おっさんの大冒険</tag>
      <tag>Oblivion</tag>
      <tag>オブリビオン</tag>
      <tag>おぽこ</tag>
      <tag>伝説の始まり</tag>
      <tag>笑撃のラスト</tag>
      <tag>ゆっくり実況プレイ</tag>
      <tag>ゆっくり実況プレイpart1リンク</tag>
    </tags>
    <tags domain="tw">
      <tag>翻譯希望</tag>
    </tags>
    <user_id>1934563</user_id>
  </thumb>
</nicovideo_thumb_response>
'''

describe "About GetThumbInfo class", ->
  describe "when create an instance with a video id", ->
    before (done) ->
      @xml = new NicoQuery.Source.GetThumbInfo xml
      done()

    it "has title", ->
      @xml.title.should.equal '【Oblivion】おっさんの大冒険１（ゆっくり実況）'

    it "has description", ->
      @xml.description.should.equal 'おっさんの生き様をとくとごらんあれ！このミリオンをいつまでも大切にしたい。そう、いつまでも・・・。おっさんがここまでこれたのも、みなさまのおかげですｍ（＿＿）ｂ次回：sm8506034　マイリス：mylist/15196568【重要】この動画ではPC版Oblivionでしか表現できないシーンが含まれます。このゲームにご興味のある方はご注意ください。'

    it "has thumbnail_url", ->
      @xml.thumbnailUrl.should.equal 'http://tn-skr4.smilevideo.jp/smile?i=8481759'

    it "has first retrieve", ->
      @xml.firstRetrieve.should.equal '2009-10-11T14:15:35+09:00'

    it "has length", ->
      @xml.length.should.equal 748

    it "has movie type", ->
      @xml.movieType.should.equal 'mp4'

    it "has size", ->
      @xml.sizeHigh.should.equal 57024573

    it "has title", ->
      @xml.sizeLow.should.equal 40574829

    it "has view count", ->
      @xml.viewCounter.should.equal 1765214

    it "has comment count", ->
      @xml.commentNum.should.equal 66152

    it "has mylist count", ->
      @xml.mylistCounter.should.equal 39026

    it "has watch url", ->
      @xml.watchUrl.should.equal 'http://www.nicovideo.jp/watch/sm8481759'

    it "has thumbnail type", ->
      @xml.thumbType.should.equal 'video'

    it "has embeddable flag", ->
      @xml.embeddable.should.equal 1

    it "has live play", ->
      @xml.noLivePlay.should.equal 0

    it "has a tag list", ->
      @xml.tags.jp[0].category.should.equal 1
      @xml.tags.jp[0].lock.should.equal 1
      @xml.tags.jp[0].string.should.equal 'ゲーム'
      @xml.tags.jp[1].string.should.equal 'おっさんの大冒険'
      @xml.tags.jp[2].string.should.equal 'Oblivion'
      @xml.tags.jp[3].string.should.equal 'オブリビオン'
      @xml.tags.jp[4].string.should.equal 'おぽこ'
      @xml.tags.jp[5].string.should.equal '伝説の始まり'
      @xml.tags.jp[6].string.should.equal '笑撃のラスト'
      @xml.tags.jp[7].string.should.equal 'ゆっくり実況プレイ'
      @xml.tags.jp[8].string.should.equal 'ゆっくり実況プレイpart1リンク'
      # @xml.tags.tw[0].string.should.equal '翻譯希望'