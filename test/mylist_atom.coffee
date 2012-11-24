_  = require 'underscore'
_.str = require 'underscore.string'
_.mixin _.str.exports()
_.str.include 'Underscore.string', 'string'

require 'should'
sinon = require 'sinon'
nock = require 'nock'
fs = require 'fs'

NicoScraper = require '../production/nicoquery.js'


xml = '''
<?xml version="1.0" encoding="utf-8"?>
<feed xmlns="http://www.w3.org/2005/Atom" xml:lang="ja">
  <title>マイリスト 【Oblivion】おっさんの大冒険‐ニコニコ動画</title>
  <subtitle>ふふ　マイリスを開いてしまいましたか＾＾</subtitle>
  <link rel="alternate" type="text/html" href="http://www.nicovideo.jp/mylist/15196568"/>
  <link rel="self" type="application/atom+xml" href="http://www.nicovideo.jp/mylist/15196568?rss=atom"/>
  <id>tag:nicovideo.jp,2009-10-11:/mylist/15196568</id>
  <updated>2012-05-17T22:28:07+09:00</updated>
  <author><name>おぽこ</name></author>
  <generator uri="http://www.nicovideo.jp/">ニコニコ動画</generator>
  <rights>(c) niwango, inc. All rights reserved.</rights>


  <entry>
    <title>【Oblivion】おっさんの大冒険１（ゆっくり実況）</title>
    <link rel="alternate" type="text/html" href="http://www.nicovideo.jp/watch/sm8481759"/>
    <id>tag:nicovideo.jp,2009-10-11:/watch/1255238132</id>
    <published>2009-10-11T14:28:25+09:00</published>
    <updated>2009-10-11T14:28:25+09:00</updated>
    <content type="html"><![CDATA[<p class="nico-thumbnail"><img alt="【Oblivion】おっさんの大冒険１（ゆっくり実況）" src="http://tn-skr4.smilevideo.jp/smile?i=8481759" width="94" height="70" border="0"/></p><p class="nico-description">おっさんの生き様をとくとごらんあれ！このミリオンをいつまでも大切にしたい。そう、いつまでも・・・。おっさんがここまでこれたのも、みなさまのおかげですｍ（＿＿）ｂ次回：sm8506034　マイリス：mylist/15196568【重要】この動画ではPC版Oblivionでしか表現できないシーンが含まれます。このゲームにご興味のある方はご注意ください。</p><p class="nico-info"><small><strong class="nico-info-length">12:28</strong>｜<strong class="nico-info-date">2009年10月11日 14：15：35</strong> 投稿</small></p>]]></content>
  </entry>

  <entry>
    <title>【Oblivion】おっさんの大冒険２（ゆっくり実況）</title>
    <link rel="alternate" type="text/html" href="http://www.nicovideo.jp/watch/sm8506034"/>
    <id>tag:nicovideo.jp,2009-10-13:/watch/1255439788</id>
    <published>2009-10-13T22:35:36+09:00</published>
    <updated>2009-10-13T22:35:36+09:00</updated>
    <content type="html"><![CDATA[<p class="nico-thumbnail"><img alt="【Oblivion】おっさんの大冒険２（ゆっくり実況）" src="http://tn-skr3.smilevideo.jp/smile?i=8506034" width="94" height="70" border="0"/></p><p class="nico-description">おっさんの旅はまだまだ続きます。一応魔法＆武器無し縛りでいこうと思います前回：sm8481759　次回：sm8539721　マイリス：mylist/15196568【重要】この動画ではPC版Oblivionでしか表現できないシーンが含まれます。このゲームにご興味のある方はご注意ください。</p><p class="nico-info"><small><strong class="nico-info-length">16:53</strong>｜<strong class="nico-info-date">2009年10月13日 22：16：30</strong> 投稿</small></p>]]></content>
  </entry>

  <entry>
    <title>【Oblivion】おっさんの大冒険３（ゆっくり実況）</title>
    <link rel="alternate" type="text/html" href="http://www.nicovideo.jp/watch/sm8539721"/>
    <id>tag:nicovideo.jp,2009-10-17:/watch/1255776463</id>
    <published>2009-10-17T19:48:42+09:00</published>
    <updated>2009-10-17T19:48:42+09:00</updated>
    <content type="html"><![CDATA[<p class="nico-thumbnail"><img alt="【Oblivion】おっさんの大冒険３（ゆっくり実況）" src="http://tn-skr2.smilevideo.jp/smile?i=8539721" width="94" height="70" border="0"/></p><p class="nico-description">おっさんの運命やいかに！？前回：sm8506034　次回：sm8606274　マイリス：mylist/15196568【重要】この動画ではPC版Oblivionでしか表現できないシーンが含まれます。このゲームにご興味のある方はご注意ください。</p><p class="nico-info"><small><strong class="nico-info-length">16:28</strong>｜<strong class="nico-info-date">2009年10月17日 19：47：46</strong> 投稿</small></p>]]></content>
  </entry>

  <entry>
    <title>【Oblivion】おっさんの大冒険４（ゆっくり実況）</title>
    <link rel="alternate" type="text/html" href="http://www.nicovideo.jp/watch/sm8606274"/>
    <id>tag:nicovideo.jp,2009-10-24:/watch/1256391663</id>
    <published>2009-10-24T22:41:16+09:00</published>
    <updated>2009-10-24T22:41:16+09:00</updated>
    <content type="html"><![CDATA[<p class="nico-thumbnail"><img alt="【Oblivion】おっさんの大冒険４（ゆっくり実況）" src="http://tn-skr3.smilevideo.jp/smile?i=8606274" width="94" height="70" border="0"/></p><p class="nico-description">全国のおっさんに夢と希望を100万回のストーカー行為を働いたおっさんに栄光あれ！続編はじわじわ作ってますので、気長にお待ちくだされ。前回：sm8539721　次回：sm8811116　マイリス：mylist/15196568ブログ⇒http://teikee.blog128.fc2.com/</p><p class="nico-info"><small><strong class="nico-info-length">16:13</strong>｜<strong class="nico-info-date">2009年10月24日 22：41：06</strong> 投稿</small></p>]]></content>
  </entry>

  <entry>
    <title>【Oblivion】おっさんの大冒険５（ゆっくり実況）</title>
    <link rel="alternate" type="text/html" href="http://www.nicovideo.jp/watch/sm8811116"/>
    <id>tag:nicovideo.jp,2009-11-15:/watch/1258225310</id>
    <published>2009-11-15T04:03:13+09:00</published>
    <updated>2009-11-15T04:03:13+09:00</updated>
    <content type="html"><![CDATA[<p class="nico-thumbnail"><img alt="【Oblivion】おっさんの大冒険５（ゆっくり実況）" src="http://tn-skr1.smilevideo.jp/smile?i=8811116" width="94" height="70" border="0"/></p><p class="nico-description">シャバに出たおっさんに活目せよ…！前回：sm8606274　次回：sm9221216　マイリス：mylist/15196568ブログ⇒http://teikee.blog128.fc2.com/</p><p class="nico-info"><small><strong class="nico-info-length">11:46</strong>｜<strong class="nico-info-date">2009年11月15日 04：01：52</strong> 投稿</small></p>]]></content>
  </entry>

  <entry>
    <title>【Oblivion】おっさんの大冒険６（ゆっくり実況）</title>
    <link rel="alternate" type="text/html" href="http://www.nicovideo.jp/watch/sm9221216"/>
    <id>tag:nicovideo.jp,2009-12-28:/watch/1261952691</id>
    <published>2009-12-28T07:25:45+09:00</published>
    <updated>2009-12-28T07:25:45+09:00</updated>
    <content type="html"><![CDATA[<p class="nico-thumbnail"><img alt="【Oblivion】おっさんの大冒険６（ゆっくり実況）" src="http://tn-skr1.smilevideo.jp/smile?i=9221216" width="94" height="70" border="0"/></p><p class="nico-description">おっさんとゴブリンとの戦いの行方は！？あけおめぐっつすっす前回：sm8811116　次回：sm10024081　マイリス：mylist/15196568ブログ⇒http://teikee.blog128.fc2.com/</p><p class="nico-info"><small><strong class="nico-info-length">13:21</strong>｜<strong class="nico-info-date">2009年12月28日 07：24：54</strong> 投稿</small></p>]]></content>
  </entry>

  <entry>
    <title>【Oblivion】おっさんの大冒険７（ゆっくり実況）</title>
    <link rel="alternate" type="text/html" href="http://www.nicovideo.jp/watch/sm10024081"/>
    <id>tag:nicovideo.jp,2010-03-14:/watch/1268546681</id>
    <published>2010-03-14T19:04:41+09:00</published>
    <updated>2010-03-14T19:04:41+09:00</updated>
    <content type="html"><![CDATA[<p class="nico-thumbnail"><img alt="【Oblivion】おっさんの大冒険７（ゆっくり実況）" src="http://tn-skr2.smilevideo.jp/smile?i=10024081" width="94" height="70" border="0"/></p><p class="nico-description">おっさん自身の幸せとは…！？前回：sm9221216　次回：sm10659358　マイリス：mylist/15196568ブログ⇒http://teikee.blog128.fc2.com/</p><p class="nico-info"><small><strong class="nico-info-length">21:29</strong>｜<strong class="nico-info-date">2010年03月14日 15：04：43</strong> 投稿</small></p>]]></content>
  </entry>

  <entry>
    <title>【Oblivion】おっさんの大冒険８（ゆっくり実況）</title>
    <link rel="alternate" type="text/html" href="http://www.nicovideo.jp/watch/sm10659358"/>
    <id>tag:nicovideo.jp,2010-05-09:/watch/1273345724</id>
    <published>2010-05-09T04:11:46+09:00</published>
    <updated>2010-05-09T04:11:46+09:00</updated>
    <content type="html"><![CDATA[<p class="nico-thumbnail"><img alt="【Oblivion】おっさんの大冒険８（ゆっくり実況）" src="http://tn-skr3.smilevideo.jp/smile?i=10659358" width="94" height="70" border="0"/></p><p class="nico-description">おっさんの守るべきものとは？前回：sm10024081　次回：sm17842779　マイリス：mylist/15196568ブログ⇒http://teikee.blog128.fc2.com/</p><p class="nico-info"><small><strong class="nico-info-length">21:47</strong>｜<strong class="nico-info-date">2010年05月09日 04：08：44</strong> 投稿</small></p>]]></content>
  </entry>

  <entry>
    <title>【Skyrim】おっさんの大冒険９（ゆっくり実況）</title>
    <link rel="alternate" type="text/html" href="http://www.nicovideo.jp/watch/sm17842779"/>
    <id>tag:nicovideo.jp,2012-05-16:/watch/1337180095</id>
    <published>2012-05-17T01:18:09+09:00</published>
    <updated>2012-05-17T01:18:09+09:00</updated>
    <content type="html"><![CDATA[<p class="nico-thumbnail"><img alt="【Skyrim】おっさんの大冒険９（ゆっくり実況）" src="http://tn-skr4.smilevideo.jp/smile?i=17842779" width="94" height="70" border="0"/></p><p class="nico-description">おっさんの戦うわけとは？前回：sm10659358　マイリス：mylist/15196568ブログ⇒http://teikee.blog128.fc2.com/</p><p class="nico-info"><small><strong class="nico-info-length">21:45</strong>｜<strong class="nico-info-date">2012年05月16日 23：54：55</strong> 投稿</small></p>]]></content>
  </entry>

</feed>
'''

describe "About MylistAtom class", ->
  describe "when create an instance", ->
    before (done) ->
      @xml = new NicoScraper.Source.MylistAtom xml
      done()

    it "has a mylist property", ->
      @xml.title.should.equal '【Oblivion】おっさんの大冒険'
      @xml.subtitle.should.equal 'ふふ　マイリスを開いてしまいましたか＾＾'
      @xml.mylistId.should.equal 15196568
      @xml.updated.should.equal '2012-05-17T22:28:07+09:00'
      @xml.author.should.equal 'おぽこ'

    it "has movies property in this mylist", ->
      @xml.entry['sm8481759'].title.should.equal '【Oblivion】おっさんの大冒険１（ゆっくり実況）'
      @xml.entry['sm8481759'].videoId.should.equal 'sm8481759'
      @xml.entry['sm8481759'].timelikeId.should.equal 1255238132
      @xml.entry['sm8481759'].thumbnailUrl.should.equal 'http://tn-skr4.smilevideo.jp/smile?i=8481759'
      @xml.entry['sm8481759'].description.should.equal 'おっさんの生き様をとくとごらんあれ！このミリオンをいつまでも大切にしたい。そう、いつまでも・・・。おっさんがここまでこれたのも、みなさまのおかげですｍ（＿＿）ｂ次回：sm8506034　マイリス：mylist/15196568【重要】この動画ではPC版Oblivionでしか表現できないシーンが含まれます。このゲームにご興味のある方はご注意ください。'
      @xml.entry['sm8481759'].length.should.equal 748
      @xml.entry['sm8481759'].infoDate.should.equal 1255238135
