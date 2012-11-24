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
<title>タグ ゆっくり実況プレイpart1リンク‐ニコニコ動画</title>
<subtitle>タグ「ゆっくり実況プレイpart1リンク」が付けられた動画 (全 5,955 件)</subtitle>
<link rel="alternate" type="text/html" href="http://www.nicovideo.jp/tag/%E3%82%86%E3%81%A3%E3%81%8F%E3%82%8A%E5%AE%9F%E6%B3%81%E3%83%97%E3%83%AC%E3%82%A4part1%E3%83%AA%E3%83%B3%E3%82%AF"/>
<link rel="self" type="application/atom+xml" href="http://www.nicovideo.jp/tag/%E3%82%86%E3%81%A3%E3%81%8F%E3%82%8A%E5%AE%9F%E6%B3%81%E3%83%97%E3%83%AC%E3%82%A4part1%E3%83%AA%E3%83%B3%E3%82%AF?rss=atom"/>
<id>tag:nicovideo.jp:/tag/%E3%82%86%E3%81%A3%E3%81%8F%E3%82%8A%E5%AE%9F%E6%B3%81%E3%83%97%E3%83%AC%E3%82%A4part1%E3%83%AA%E3%83%B3%E3%82%AF</id>
<updated>2012-05-19T22:10:25+09:00</updated>
<author><name>ニコニコ動画</name></author>
<generator uri="http://www.nicovideo.jp/">ニコニコ動画</generator>
<rights>(c) niwango, inc. All rights reserved.</rights>

<entry>
  <title>【ゆっくり実況】月風魔伝　その1</title>
  <link rel="alternate" type="text/html" href="http://www.nicovideo.jp/watch/sm17854700"/>
  <id>tag:nicovideo.jp,2012-05-18:/watch/sm17854700</id>
  <published>2012-05-18T17:45:05+09:00</published>
  <updated>2012-05-19T21:59:50+09:00</updated>
  <content type="html"><![CDATA[
    <div xmlns="http://www.w3.org/1999/xhtml">
      <p class="nico-thumbnail"><img alt="【ゆっくり実況】月風魔伝　その1" src="http://tn-skr1.smilevideo.jp/smile?i=17854700" width="94" height="70" border="0"/></p>
      <p class="nico-description">戻って参りました。頑張らせていただきます！月風魔伝ゆっくり実況まとめ→mylist/32058660単発まとめ→mylist/25326423シリーズ物part1まとめ→mylist/28984</p>
      <p class="nico-info"><small><strong class="nico-info-length">8:40</strong>｜<strong class="nico-info-date">2012年05月18日 17：45：05</strong> 投稿</small></p>
    </div>
  ]]></content>
</entry>
<entry>
  <title>【ゆっくり実況プレイ】ペプシマアアアアアアアアアアアアアアアンpart1</title>
  <link rel="alternate" type="text/html" href="http://www.nicovideo.jp/watch/sm17861875"/>
  <id>tag:nicovideo.jp,2012-05-19:/watch/sm17861875</id>
  <published>2012-05-19T11:21:18+09:00</published>
  <updated>2012-05-19T21:58:12+09:00</updated>
  <content type="html"><![CDATA[
    <div xmlns="http://www.w3.org/1999/xhtml">
      <p class="nico-thumbnail"><img alt="【ゆっくり実況プレイ】ペプシマアアアアアアアアアアアアアアアンpart1" src="http://tn-skr4.smilevideo.jp/smile?i=17861875" width="94" height="70" border="0"/></p>
      <p class="nico-description">人類には、ペプシコーラが必要だ！PEPSI MAN（ペプシマン）のゆっくり実況プレイ動画864x486今回のシリーズで動画編集の技術を上げたいものです。mylist/3</p>
      <p class="nico-info"><small><strong class="nico-info-length">10:31</strong>｜<strong class="nico-info-date">2012年05月19日 11：21：18</strong> 投稿</small></p>
    </div>
  ]]></content>
</entry>
<entry>
  <title>【ゆっくり実況】Minecraft 　ダラダラ開拓がしていきたい　Part.1【XBLA】</title>
  <link rel="alternate" type="text/html" href="http://www.nicovideo.jp/watch/sm17845120"/>
  <id>tag:nicovideo.jp,2012-05-17:/watch/sm17845120</id>
  <published>2012-05-17T10:01:40+09:00</published>
  <updated>2012-05-19T21:58:11+09:00</updated>
  <content type="html"><![CDATA[
    <div xmlns="http://www.w3.org/1999/xhtml">
      <p class="nico-thumbnail"><img alt="【ゆっくり実況】Minecraft 　ダラダラ開拓がしていきたい　Part.1【XBLA】" src="http://tn-skr1.smilevideo.jp/smile?i=17845120" width="94" height="70" border="0"/></p>
      <p class="nico-description">はじめまして今回が初めての、ゆっくり実況になります。至らない点も多いと思いますが、宜しくお願い致します。縛りも考えていません。ただダラダラと箱版</p>
      <p class="nico-info"><small><strong class="nico-info-length">17:11</strong>｜<strong class="nico-info-date">2012年05月17日 10：01：40</strong> 投稿</small></p>
    </div>
  ]]></content>
</entry>
<entry>
  <title>【ゆっくり実況】潜入する気のない魔理沙のMGSPW　Part1</title>
  <link rel="alternate" type="text/html" href="http://www.nicovideo.jp/watch/sm17854863"/>
  <id>tag:nicovideo.jp,2012-05-18:/watch/sm17854863</id>
  <published>2012-05-18T17:34:20+09:00</published>
  <updated>2012-05-19T21:57:06+09:00</updated>
  <content type="html"><![CDATA[
    <div xmlns="http://www.w3.org/1999/xhtml">
      <p class="nico-thumbnail"><img alt="【ゆっくり実況】潜入する気のない魔理沙のMGSPW　Part1" src="http://tn-skr4.smilevideo.jp/smile?i=17854863" width="94" height="70" border="0"/></p>
      <p class="nico-description">PS3版「MGSPW HDエディション」のゆっくり実況プレイMGSシリーズが好きすぎてついに動画を上げてみましたムービーは実況動画などで見ずに、自分の手でプレ</p>
      <p class="nico-info"><small><strong class="nico-info-length">12:10</strong>｜<strong class="nico-info-date">2012年05月18日 17：34：20</strong> 投稿</small></p>
    </div>
  ]]></content>
</entry>
<entry>
  <title>【ゼルダの伝説】 大地の章をゆっくり実況 Part.1 【ふしぎの木の実】</title>
  <link rel="alternate" type="text/html" href="http://www.nicovideo.jp/watch/sm17856236"/>
  <id>tag:nicovideo.jp,2012-05-18:/watch/sm17856236</id>
  <published>2012-05-18T20:25:25+09:00</published>
  <updated>2012-05-19T21:53:13+09:00</updated>
  <content type="html"><![CDATA[
    <div xmlns="http://www.w3.org/1999/xhtml">
      <p class="nico-thumbnail"><img alt="【ゼルダの伝説】 大地の章をゆっくり実況 Part.1 【ふしぎの木の実】" src="http://tn-skr1.smilevideo.jp/smile?i=17856236" width="94" height="70" border="0"/></p>
      <p class="nico-description">息抜きに大地の章を実況！編集も凝ったものにしないため退屈な動画になること請け合い！　暇つぶしにみてね※Part1なのでカット編集や凝った編集はいれてま</p>
      <p class="nico-info"><small><strong class="nico-info-length">15:12</strong>｜<strong class="nico-info-date">2012年05月18日 20：25：25</strong> 投稿</small></p>
    </div>
  ]]></content>
</entry>
<entry>
  <title>【ゆっくり実況】ハウスオブザデッド３ Part.1</title>
  <link rel="alternate" type="text/html" href="http://www.nicovideo.jp/watch/sm17858831"/>
  <id>tag:nicovideo.jp,2012-05-19:/watch/sm17858831</id>
  <published>2012-05-19T00:14:39+09:00</published>
  <updated>2012-05-19T21:52:33+09:00</updated>
  <content type="html"><![CDATA[
    <div xmlns="http://www.w3.org/1999/xhtml">
      <p class="nico-thumbnail"><img alt="【ゆっくり実況】ハウスオブザデッド３ Part.1" src="http://tn-skr4.smilevideo.jp/smile?i=17858831" width="94" height="70" border="0"/></p>
      <p class="nico-description">初めましての方は初めまして。前作見てくださった方はお久しぶりです。今回は「ハウスオブザデッド３」をやっていきます。ま、正確に言いますと、HOTD3の</p>
      <p class="nico-info"><small><strong class="nico-info-length">5:47</strong>｜<strong class="nico-info-date">2012年05月19日 00：14：39</strong> 投稿</small></p>
    </div>
  ]]></content>
</entry>
<entry>
  <title>ゆっくり初心者達のダブルクロス　Part1UGN編</title>
  <link rel="alternate" type="text/html" href="http://www.nicovideo.jp/watch/sm17827804"/>
  <id>tag:nicovideo.jp,2012-05-15:/watch/sm17827804</id>
  <published>2012-05-15T02:00:11+09:00</published>
  <updated>2012-05-19T21:45:47+09:00</updated>
  <content type="html"><![CDATA[
    <div xmlns="http://www.w3.org/1999/xhtml">
      <p class="nico-thumbnail"><img alt="ゆっくり初心者達のダブルクロス　Part1UGN編" src="http://tn-skr1.smilevideo.jp/smile?i=17827804" width="94" height="70" border="0"/></p>
      <p class="nico-description">今回キャラ紹介編のみです。皆様まずはあやまらせてください！更新遅れてしまい大変申し訳ございませんでした！ 今回最後の方に視聴者の皆様に質問がござ</p>
      <p class="nico-info"><small><strong class="nico-info-length">9:40</strong>｜<strong class="nico-info-date">2012年05月15日 02：00：11</strong> 投稿</small></p>
    </div>
  ]]></content>
</entry>
<entry>
  <title>発売元に恵まれなかったナツメの2ＤＡＣＴをゆっくり実況【ＧＳ美神①】</title>
  <link rel="alternate" type="text/html" href="http://www.nicovideo.jp/watch/sm17853675"/>
  <id>tag:nicovideo.jp,2012-05-19:/watch/sm17853675</id>
  <published>2012-05-19T12:11:56+09:00</published>
  <updated>2012-05-19T21:36:56+09:00</updated>
  <content type="html"><![CDATA[
    <div xmlns="http://www.w3.org/1999/xhtml">
      <p class="nico-thumbnail"><img alt="発売元に恵まれなかったナツメの2ＤＡＣＴをゆっくり実況【ＧＳ美神①】" src="http://tn-skr4.smilevideo.jp/smile?i=17853675" width="94" height="70" border="0"/></p>
      <p class="nico-description">ＳＦＣでバナレックス（バンダイの子会社）から発売された「ＧＳ美神～除霊師はナイスバディ～」のゆっくり実況プレイです一見アクションゲームとしてもキ</p>
      <p class="nico-info"><small><strong class="nico-info-length">11:45</strong>｜<strong class="nico-info-date">2012年05月19日 12：11：56</strong> 投稿</small></p>
    </div>
  ]]></content>
</entry>
<entry>
  <title>【ゆっくり】探せ！新鮮な寿司ネタ実況1＆ゆっくり歴史解説【ForeverBlue】</title>
  <link rel="alternate" type="text/html" href="http://www.nicovideo.jp/watch/sm17848184"/>
  <id>tag:nicovideo.jp,2012-05-17:/watch/sm17848184</id>
  <published>2012-05-17T20:27:56+09:00</published>
  <updated>2012-05-19T20:59:08+09:00</updated>
  <content type="html"><![CDATA[
    <div xmlns="http://www.w3.org/1999/xhtml">
      <p class="nico-thumbnail"><img alt="【ゆっくり】探せ！新鮮な寿司ネタ実況1＆ゆっくり歴史解説【ForeverBlue】" src="http://tn-skr1.smilevideo.jp/smile?i=17848184" width="94" height="70" border="0"/></p>
      <p class="nico-description">　初投稿ゆっくり実況です！＼(^o^)／　前半で「ゆっくり実況」誕生の歴史について初心者目線で解説していき、後半で本編実況をするスタイルをとっていま</p>
      <p class="nico-info"><small><strong class="nico-info-length">20:00</strong>｜<strong class="nico-info-date">2012年05月17日 20：27：56</strong> 投稿</small></p>
    </div>
  ]]></content>
</entry>
<entry>
  <title>【ゆっくり実況】ガチモンとランフリ【ポケモンＢＷ】96 兄貴達と実況</title>
  <link rel="alternate" type="text/html" href="http://www.nicovideo.jp/watch/sm17851614"/>
  <id>tag:nicovideo.jp,2012-05-18:/watch/sm17851614</id>
  <published>2012-05-18T01:54:34+09:00</published>
  <updated>2012-05-19T20:55:31+09:00</updated>
  <content type="html"><![CDATA[
    <div xmlns="http://www.w3.org/1999/xhtml">
      <p class="nico-thumbnail"><img alt="【ゆっくり実況】ガチモンとランフリ【ポケモンＢＷ】96 兄貴達と実況" src="http://tn-skr3.smilevideo.jp/smile?i=17851614" width="94" height="70" border="0"/></p>
      <p class="nico-description">おばんです。予告通りガチモンパにてランダムフリーに潜りますレスリング動画に肉声を載せるのがおこがましいと思いゆっくり実況にしましたレスリングシリ</p>
      <p class="nico-info"><small><strong class="nico-info-length">13:03</strong>｜<strong class="nico-info-date">2012年05月18日 01：54：34</strong> 投稿</small></p>
    </div>
  ]]></content>
</entry>
<entry>
  <title>初心者による初ｓ（中略）ゆっくりだらけのＴＲＰＧ part0【クトゥルフ】</title>
  <link rel="alternate" type="text/html" href="http://www.nicovideo.jp/watch/sm17855003"/>
  <id>tag:nicovideo.jp,2012-05-18:/watch/sm17855003</id>
  <published>2012-05-18T18:14:58+09:00</published>
  <updated>2012-05-19T20:31:19+09:00</updated>
  <content type="html"><![CDATA[
    <div xmlns="http://www.w3.org/1999/xhtml">
      <p class="nico-thumbnail"><img alt="初心者による初ｓ（中略）ゆっくりだらけのＴＲＰＧ part0【クトゥルフ】" src="http://tn-skr4.smilevideo.jp/smile?i=17855003" width="94" height="70" border="0"/></p>
      <p class="nico-description">※注意※・初心者しかいない・兎に角初心者しかいない・だからいっぱい間違える・gdgd・サンプルシナリオ・ルルブの読み込みも甘い・俄か知識それでもいいっ</p>
      <p class="nico-info"><small><strong class="nico-info-length">6:48</strong>｜<strong class="nico-info-date">2012年05月18日 18：14：58</strong> 投稿</small></p>
    </div>
  ]]></content>
</entry>
<entry>
  <title>【Ib】ゆっくり4人でｶｵｽ実況！Part1【ゆっくり実況プレイ】</title>
  <link rel="alternate" type="text/html" href="http://www.nicovideo.jp/watch/sm17863095"/>
  <id>tag:nicovideo.jp,2012-05-19:/watch/sm17863095</id>
  <published>2012-05-19T14:19:10+09:00</published>
  <updated>2012-05-19T20:30:10+09:00</updated>
  <content type="html"><![CDATA[
    <div xmlns="http://www.w3.org/1999/xhtml">
      <p class="nico-thumbnail"><img alt="【Ib】ゆっくり4人でｶｵｽ実況！Part1【ゆっくり実況プレイ】" src="http://tn-skr4.smilevideo.jp/smile?i=17863095" width="94" height="70" border="0"/></p>
      <p class="nico-description">カオス注意次：未定[追記]一番最後の音声はきめえまるに喋らせるハズでしたミスしました</p>
      <p class="nico-info"><small><strong class="nico-info-length">12:34</strong>｜<strong class="nico-info-date">2012年05月19日 14：19：10</strong> 投稿</small></p>
    </div>
  ]]></content>
</entry>
<entry>
  <title>【ゆっくり実況】信長の野望 革新PK 【島津家プレイ】</title>
  <link rel="alternate" type="text/html" href="http://www.nicovideo.jp/watch/sm16436717"/>
  <id>tag:nicovideo.jp,2011-12-16:/watch/sm16436717</id>
  <published>2011-12-16T02:30:17+09:00</published>
  <updated>2012-05-19T20:25:35+09:00</updated>
  <content type="html"><![CDATA[
    <div xmlns="http://www.w3.org/1999/xhtml">
      <p class="nico-thumbnail"><img alt="【ゆっくり実況】信長の野望 革新PK 【島津家プレイ】" src="http://tn-skr2.smilevideo.jp/smile?i=16436717" width="94" height="70" border="0"/></p>
      <p class="nico-description">実況動画投稿は初めてだから、優しくしてね。音ずれが発生したため、３分半は無音です(BGMはゲームと無関係なものを付けました)。訂正・最後の方で戦法の</p>
      <p class="nico-info"><small><strong class="nico-info-length">27:10</strong>｜<strong class="nico-info-date">2011年12月16日 02：30：17</strong> 投稿</small></p>
    </div>
  ]]></content>
</entry>
<entry>
  <title>【Minecraft】ゆっくりマ○オのマインクラフト実況【ゆっくり実況】-Part0</title>
  <link rel="alternate" type="text/html" href="http://www.nicovideo.jp/watch/sm17855026"/>
  <id>tag:nicovideo.jp,2012-05-18:/watch/sm17855026</id>
  <published>2012-05-18T17:58:03+09:00</published>
  <updated>2012-05-19T20:25:24+09:00</updated>
  <content type="html"><![CDATA[
    <div xmlns="http://www.w3.org/1999/xhtml">
      <p class="nico-thumbnail"><img alt="【Minecraft】ゆっくりマ○オのマインクラフト実況【ゆっくり実況】-Part0" src="http://tn-skr3.smilevideo.jp/smile?i=17855026" width="94" height="70" border="0"/></p>
      <p class="nico-description">初めて、ゆっくり実況を製作しています。至らない点が多いと思いますが、暖かい目で見守ってくださると助かります。また、マインクラフトに関しても初心者</p>
      <p class="nico-info"><small><strong class="nico-info-length">8:54</strong>｜<strong class="nico-info-date">2012年05月18日 17：58：03</strong> 投稿</small></p>
    </div>
  ]]></content>
</entry>
<entry>
  <title>ゆっくり実況 3人PTで「剣と魔法と学園モノ。3」part.01</title>
  <link rel="alternate" type="text/html" href="http://www.nicovideo.jp/watch/sm15788405"/>
  <id>tag:nicovideo.jp,2011-10-04:/watch/sm15788405</id>
  <published>2011-10-04T01:14:13+09:00</published>
  <updated>2012-05-19T20:25:06+09:00</updated>
  <content type="html"><![CDATA[
    <div xmlns="http://www.w3.org/1999/xhtml">
      <p class="nico-thumbnail"><img alt="ゆっくり実況 3人PTで「剣と魔法と学園モノ。3」part.01" src="http://tn-skr2.smilevideo.jp/smile?i=15788405" width="94" height="70" border="0"/></p>
      <p class="nico-description">ゆっくり実況初投稿です。まだまだ荒い点が多いですが、よろしくお願いします。あ、普段はエロゲ紹介動画やってます。【縛り内容】①3人パーティーで進行②</p>
      <p class="nico-info"><small><strong class="nico-info-length">24:10</strong>｜<strong class="nico-info-date">2011年10月04日 01：14：13</strong> 投稿</small></p>
    </div>
  ]]></content>
</entry>
<entry>
  <title>【PCE】イースⅠ 01 エステリア紀行【Ys】</title>
  <link rel="alternate" type="text/html" href="http://www.nicovideo.jp/watch/sm10717490"/>
  <id>tag:nicovideo.jp,2010-05-14:/watch/sm10717490</id>
  <published>2010-05-14T20:33:56+09:00</published>
  <updated>2012-05-19T20:24:33+09:00</updated>
  <content type="html"><![CDATA[
    <div xmlns="http://www.w3.org/1999/xhtml">
      <p class="nico-thumbnail"><img alt="【PCE】イースⅠ 01 エステリア紀行【Ys】" src="http://tn-skr3.smilevideo.jp/smile?i=10717490" width="94" height="70" border="0"/></p>
      <p class="nico-description">mylist/11976891次回 sm10794126オープニング → 神殿ボスゆっくりボイスは控えめです。昔を懐かしむ程度にどうぞ。動画が重いという方がいましたらコメ下</p>
      <p class="nico-info"><small><strong class="nico-info-length">22:09</strong>｜<strong class="nico-info-date">2010年05月14日 20：33：56</strong> 投稿</small></p>
    </div>
  ]]></content>
</entry>
<entry>
  <title>PC初心者のマインクラフト　1</title>
  <link rel="alternate" type="text/html" href="http://www.nicovideo.jp/watch/sm16145233"/>
  <id>tag:nicovideo.jp,2011-11-12:/watch/sm16145233</id>
  <published>2011-11-12T02:55:38+09:00</published>
  <updated>2012-05-19T20:24:32+09:00</updated>
  <content type="html"><![CDATA[
    <div xmlns="http://www.w3.org/1999/xhtml">
      <p class="nico-thumbnail"><img alt="PC初心者のマインクラフト　1" src="http://tn-skr2.smilevideo.jp/smile?i=16145233" width="94" height="70" border="0"/></p>
      <p class="nico-description">テストを兼ねて作りました。スキンはケめジほ日記。さんからお借りしました。次から本編で最初からやります。次→sm16161995　mylist/28873300</p>
      <p class="nico-info"><small><strong class="nico-info-length">9:04</strong>｜<strong class="nico-info-date">2011年11月12日 02：55：38</strong> 投稿</small></p>
    </div>
  ]]></content>
</entry>
<entry>
  <title>【ゆっくり実況】ぼくともえもん。　part1【萌えっ娘もんすたぁ】</title>
  <link rel="alternate" type="text/html" href="http://www.nicovideo.jp/watch/sm10040103"/>
  <id>tag:nicovideo.jp,2010-03-15:/watch/sm10040103</id>
  <published>2010-03-15T21:21:54+09:00</published>
  <updated>2012-05-19T20:24:16+09:00</updated>
  <content type="html"><![CDATA[
    <div xmlns="http://www.w3.org/1999/xhtml">
      <p class="nico-thumbnail"><img alt="【ゆっくり実況】ぼくともえもん。　part1【萌えっ娘もんすたぁ】" src="http://tn-skr4.smilevideo.jp/smile?i=10040103" width="94" height="70" border="0"/></p>
      <p class="nico-description">-萌えっ娘もんすたぁ　ゆっくり実況-はじめまして。「萌えっこモンスター　鹿ver477」をゆっくり実況させてもらいます、篇那唆凪（へんなさなぎ）と申しま</p>
      <p class="nico-info"><small><strong class="nico-info-length">8:43</strong>｜<strong class="nico-info-date">2010年03月15日 21：21：54</strong> 投稿</small></p>
    </div>
  ]]></content>
</entry>
<entry>
  <title>[ゆっくり実況][COD:BO]～主と戦友で行くゾンビ縛り旅～その１</title>
  <link rel="alternate" type="text/html" href="http://www.nicovideo.jp/watch/sm14202046"/>
  <id>tag:nicovideo.jp,2011-04-19:/watch/sm14202046</id>
  <published>2011-04-19T10:20:38+09:00</published>
  <updated>2012-05-19T20:23:39+09:00</updated>
  <content type="html"><![CDATA[
    <div xmlns="http://www.w3.org/1999/xhtml">
      <p class="nico-thumbnail"><img alt="[ゆっくり実況][COD:BO]～主と戦友で行くゾンビ縛り旅～その１" src="http://tn-skr3.smilevideo.jp/smile?i=14202046" width="94" height="70" border="0"/></p>
      <p class="nico-description">みなさんおはこんばんわ、けんのです。好きな食べ物は初音ミクです。やっと次回動画ができた。今回はCOD：BOのゾンビモードで武器を縛っていく限界に挑戦</p>
      <p class="nico-info"><small><strong class="nico-info-length">16:44</strong>｜<strong class="nico-info-date">2011年04月19日 10：20：38</strong> 投稿</small></p>
    </div>
  ]]></content>
</entry>
<entry>
  <title>【skyrim】とあるビッチの暗殺家業　其の一殺【ゆっくり実況】</title>
  <link rel="alternate" type="text/html" href="http://www.nicovideo.jp/watch/sm17794439"/>
  <id>tag:nicovideo.jp,2012-05-11:/watch/sm17794439</id>
  <published>2012-05-11T19:56:32+09:00</published>
  <updated>2012-05-19T20:23:15+09:00</updated>
  <content type="html"><![CDATA[
    <div xmlns="http://www.w3.org/1999/xhtml">
      <p class="nico-thumbnail"><img alt="【skyrim】とあるビッチの暗殺家業　其の一殺【ゆっくり実況】" src="http://tn-skr4.smilevideo.jp/smile?i=17794439" width="94" height="70" border="0"/></p>
      <p class="nico-description">The Elder Scrolls V : Skyrim、PC日本語版のゆっくり実況プレイです。うｐ主はこのゲームをプレイ済みです。暗殺ギルドのクエストを進めていきます。メイ</p>
      <p class="nico-info"><small><strong class="nico-info-length">16:10</strong>｜<strong class="nico-info-date">2012年05月11日 19：56：32</strong> 投稿</small></p>
    </div>
  ]]></content>
</entry>
<entry>
  <title>【ゆっくり実況】二人で行く星のカービィスーパーデラックス　part1</title>
  <link rel="alternate" type="text/html" href="http://www.nicovideo.jp/watch/sm14002156"/>
  <id>tag:nicovideo.jp,2011-03-29:/watch/sm14002156</id>
  <published>2011-03-29T22:42:08+09:00</published>
  <updated>2012-05-19T20:23:02+09:00</updated>
  <content type="html"><![CDATA[
    <div xmlns="http://www.w3.org/1999/xhtml">
      <p class="nico-thumbnail"><img alt="【ゆっくり実況】二人で行く星のカービィスーパーデラックス　part1" src="http://tn-skr1.smilevideo.jp/smile?i=14002156" width="94" height="70" border="0"/></p>
      <p class="nico-description">はじめまして。ゆっくりまふもふと言うものです。動画製作自体初めてですががんばって作りました。カービィ：れいむ　　　ヘルパー：まりさ次→sm14045496</p>
      <p class="nico-info"><small><strong class="nico-info-length">6:35</strong>｜<strong class="nico-info-date">2011年03月29日 22：42：08</strong> 投稿</small></p>
    </div>
  ]]></content>
</entry>
<entry>
  <title>【Oblivion】おっさんの大冒険１（ゆっくり実況）</title>
  <link rel="alternate" type="text/html" href="http://www.nicovideo.jp/watch/sm8481759"/>
  <id>tag:nicovideo.jp,2009-10-11:/watch/sm8481759</id>
  <published>2009-10-11T14:15:35+09:00</published>
  <updated>2012-05-19T20:22:58+09:00</updated>
  <content type="html"><![CDATA[
    <div xmlns="http://www.w3.org/1999/xhtml">
      <p class="nico-thumbnail"><img alt="【Oblivion】おっさんの大冒険１（ゆっくり実況）" src="http://tn-skr4.smilevideo.jp/smile?i=8481759" width="94" height="70" border="0"/></p>
      <p class="nico-description">おっさんの生き様をとくとごらんあれ！このミリオンをいつまでも大切にしたい。そう、いつまでも・・・。おっさんがここまでこれたのも、みなさまのおかげ</p>
      <p class="nico-info"><small><strong class="nico-info-length">12:28</strong>｜<strong class="nico-info-date">2009年10月11日 14：15：35</strong> 投稿</small></p>
    </div>
  ]]></content>
</entry>
<entry>
  <title>【ゆっくり】150AA10↑野手能力オールA二刀流作るよ【パワプロ12決Part1】</title>
  <link rel="alternate" type="text/html" href="http://www.nicovideo.jp/watch/sm17799524"/>
  <id>tag:nicovideo.jp,2012-05-12:/watch/sm17799524</id>
  <published>2012-05-12T08:48:05+09:00</published>
  <updated>2012-05-19T20:20:50+09:00</updated>
  <content type="html"><![CDATA[
    <div xmlns="http://www.w3.org/1999/xhtml">
      <p class="nico-thumbnail"><img alt="【ゆっくり】150AA10↑野手能力オールA二刀流作るよ【パワプロ12決Part1】" src="http://tn-skr1.smilevideo.jp/smile?i=17799524" width="94" height="70" border="0"/></p>
      <p class="nico-description">パワプロ12(GC版)決定版。誰もが夢見る「エースで四番」、所謂二刀流投手作成のゆっくり実況です。目標:「投手150AA総変10以上、野手能力オールA」　理論</p>
      <p class="nico-info"><small><strong class="nico-info-length">16:27</strong>｜<strong class="nico-info-date">2012年05月12日 08：48：05</strong> 投稿</small></p>
    </div>
  ]]></content>
</entry>
<entry>
  <title>[ゆっくり実況]クトゥルーの呼び声[TRPG]</title>
  <link rel="alternate" type="text/html" href="http://www.nicovideo.jp/watch/sm17488321"/>
  <id>tag:nicovideo.jp,2012-04-08:/watch/sm17488321</id>
  <published>2012-04-08T01:22:58+09:00</published>
  <updated>2012-05-19T20:19:49+09:00</updated>
  <content type="html"><![CDATA[
    <div xmlns="http://www.w3.org/1999/xhtml">
      <p class="nico-thumbnail"><img alt="[ゆっくり実況]クトゥルーの呼び声[TRPG]" src="http://tn-skr2.smilevideo.jp/smile?i=17488321" width="94" height="70" border="0"/></p>
      <p class="nico-description">いやぁ最近面白い動画がふえましたねぇ。　　　　　　　　　　　　　　　　　　　　　　　　　　　というわけで私もそんな動画を目指して頑張ります。　　</p>
      <p class="nico-info"><small><strong class="nico-info-length">11:07</strong>｜<strong class="nico-info-date">2012年04月08日 01：22：58</strong> 投稿</small></p>
    </div>
  ]]></content>
</entry>
<entry>
  <title>【Minecraft】海底宮殿を建造する挑戦　水深１ｍ</title>
  <link rel="alternate" type="text/html" href="http://www.nicovideo.jp/watch/sm14227709"/>
  <id>tag:nicovideo.jp,2011-04-22:/watch/sm14227709</id>
  <published>2011-04-22T13:11:41+09:00</published>
  <updated>2012-05-19T20:18:06+09:00</updated>
  <content type="html"><![CDATA[
    <div xmlns="http://www.w3.org/1999/xhtml">
      <p class="nico-thumbnail"><img alt="【Minecraft】海底宮殿を建造する挑戦　水深１ｍ" src="http://tn-skr2.smilevideo.jp/smile?i=14227709" width="94" height="70" border="0"/></p>
      <p class="nico-description">ついにマイクラうｐ、aviutlのフラッシュ読み込みでコケたェ・・・開始からのプレイじゃないですがご容赦をリスト：mylist/25076149　　次：sm14267095</p>
      <p class="nico-info"><small><strong class="nico-info-length">6:24</strong>｜<strong class="nico-info-date">2011年04月22日 13：11：41</strong> 投稿</small></p>
    </div>
  ]]></content>
</entry>
<entry>
  <title>[ゆっくり解説]ゆっくり霊夢と魔理沙のガンダム講座　一年戦争　その１</title>
  <link rel="alternate" type="text/html" href="http://www.nicovideo.jp/watch/sm15310680"/>
  <id>tag:nicovideo.jp,2011-08-15:/watch/sm15310680</id>
  <published>2011-08-15T01:42:10+09:00</published>
  <updated>2012-05-19T20:17:44+09:00</updated>
  <content type="html"><![CDATA[
    <div xmlns="http://www.w3.org/1999/xhtml">
      <p class="nico-thumbnail"><img alt="[ゆっくり解説]ゆっくり霊夢と魔理沙のガンダム講座　一年戦争　その１" src="http://tn-skr1.smilevideo.jp/smile?i=15310680" width="94" height="70" border="0"/></p>
      <p class="nico-description">最初の４０秒作るのに６時間かかった。アニメーターってすごいね。独断と偏見で解説してます。ゆっくり制作していくつもりです　mylist/7435782　8/19追記</p>
      <p class="nico-info"><small><strong class="nico-info-length">18:54</strong>｜<strong class="nico-info-date">2011年08月15日 01：42：10</strong> 投稿</small></p>
    </div>
  ]]></content>
</entry>
<entry>
  <title>ゆっくりが七不思議な学校から脱出するようです　①【いちろ少年忌憚】</title>
  <link rel="alternate" type="text/html" href="http://www.nicovideo.jp/watch/sm10487101"/>
  <id>tag:nicovideo.jp,2010-04-24:/watch/sm10487101</id>
  <published>2010-04-24T05:41:03+09:00</published>
  <updated>2012-05-19T20:15:25+09:00</updated>
  <content type="html"><![CDATA[
    <div xmlns="http://www.w3.org/1999/xhtml">
      <p class="nico-thumbnail"><img alt="ゆっくりが七不思議な学校から脱出するようです　①【いちろ少年忌憚】" src="http://tn-skr2.smilevideo.jp/smile?i=10487101" width="94" height="70" border="0"/></p>
      <p class="nico-description">ゆっくりが実況したそうにこちらを見ていたので…       　　　 今までにうｐしたもの⇒　　　mylist/18091280　　　　　　　　＊動画を見る際についての注</p>
      <p class="nico-info"><small><strong class="nico-info-length">15:06</strong>｜<strong class="nico-info-date">2010年04月24日 05：41：03</strong> 投稿</small></p>
    </div>
  ]]></content>
</entry>
<entry>
  <title>◆スーパーリアルクラフト！ ゆっくりPart.1</title>
  <link rel="alternate" type="text/html" href="http://www.nicovideo.jp/watch/sm16967710"/>
  <id>tag:nicovideo.jp,2012-02-14:/watch/sm16967710</id>
  <published>2012-02-14T10:54:52+09:00</published>
  <updated>2012-05-19T20:14:55+09:00</updated>
  <content type="html"><![CDATA[
    <div xmlns="http://www.w3.org/1999/xhtml">
      <p class="nico-thumbnail"><img alt="◆スーパーリアルクラフト！ ゆっくりPart.1" src="http://tn-skr3.smilevideo.jp/smile?i=16967710" width="94" height="70" border="0"/></p>
      <p class="nico-description">リアルな世界を冒険するよ！！導入MOD一覧・シリーズに関するQ&amp;Aなど：co1524856スクリーンショットなど：http://vananan777.blog.fc2.com/おたより募集！</p>
      <p class="nico-info"><small><strong class="nico-info-length">7:53</strong>｜<strong class="nico-info-date">2012年02月14日 10：54：52</strong> 投稿</small></p>
    </div>
  ]]></content>
</entry>
<entry>
  <title>【FEZ（フェズ）】 この2.5次元でドット絵な世界をゆっくり冒険する Part.01</title>
  <link rel="alternate" type="text/html" href="http://www.nicovideo.jp/watch/sm17552047"/>
  <id>tag:nicovideo.jp,2012-04-15:/watch/sm17552047</id>
  <published>2012-04-15T06:47:01+09:00</published>
  <updated>2012-05-19T20:13:14+09:00</updated>
  <content type="html"><![CDATA[
    <div xmlns="http://www.w3.org/1999/xhtml">
      <p class="nico-thumbnail"><img alt="【FEZ（フェズ）】 この2.5次元でドット絵な世界をゆっくり冒険する Part.01" src="http://tn-skr4.smilevideo.jp/smile?i=17552047" width="94" height="70" border="0"/></p>
      <p class="nico-description">初めて作成したゆっくり実況動画です、よろしくお願いしますこの動画は先日ライブアーケードで配信が開始されたパズルアクション『FEZ(フェズ)』のゆっく</p>
      <p class="nico-info"><small><strong class="nico-info-length">19:46</strong>｜<strong class="nico-info-date">2012年04月15日 06：47：01</strong> 投稿</small></p>
    </div>
  ]]></content>
</entry>
<entry>
  <title>【Skyrim】全裸でSkyrim part1【ゆっくりモザイク実況】</title>
  <link rel="alternate" type="text/html" href="http://www.nicovideo.jp/watch/sm17095763"/>
  <id>tag:nicovideo.jp,2012-02-27:/watch/sm17095763</id>
  <published>2012-02-27T20:07:32+09:00</published>
  <updated>2012-05-19T20:12:19+09:00</updated>
  <content type="html"><![CDATA[
    <div xmlns="http://www.w3.org/1999/xhtml">
      <p class="nico-thumbnail"><img alt="【Skyrim】全裸でSkyrim part1【ゆっくりモザイク実況】" src="http://tn-skr4.smilevideo.jp/smile?i=17095763" width="94" height="70" border="0"/></p>
      <p class="nico-description">Mosaic1「僕は変態じゃない」「ドラゴンがヘルゲンを襲った」内戦で疲弊するスカイリムでそんな奇妙な噂が流れていた。そんな中、ホワイトラン城門で一人</p>
      <p class="nico-info"><small><strong class="nico-info-length">11:20</strong>｜<strong class="nico-info-date">2012年02月27日 20：07：32</strong> 投稿</small></p>
    </div>
  ]]></content>
</entry>
<entry>
  <title>【ゆっくりパワプロ12決】天才型里崎のプロテスト編【Part1】</title>
  <link rel="alternate" type="text/html" href="http://www.nicovideo.jp/watch/sm16191139"/>
  <id>tag:nicovideo.jp,2011-11-17:/watch/sm16191139</id>
  <published>2011-11-17T06:33:37+09:00</published>
  <updated>2012-05-19T20:08:45+09:00</updated>
  <content type="html"><![CDATA[
    <div xmlns="http://www.w3.org/1999/xhtml">
      <p class="nico-thumbnail"><img alt="【ゆっくりパワプロ12決】天才型里崎のプロテスト編【Part1】" src="http://tn-skr4.smilevideo.jp/smile?i=16191139" width="94" height="70" border="0"/></p>
      <p class="nico-description">おまけが本編なのかも｡なんてことをしてくれたのでしょう。文字送りがかなり早送りになってますね　ごめんなさい。今回も2週間ずつプレイ非キャプテンなの</p>
      <p class="nico-info"><small><strong class="nico-info-length">15:09</strong>｜<strong class="nico-info-date">2011年11月17日 06：33：37</strong> 投稿</small></p>
    </div>
  ]]></content>
</entry>
<entry>
  <title>ゆっくり実況[Silent Hill Shattered Memories] Part 1</title>
  <link rel="alternate" type="text/html" href="http://www.nicovideo.jp/watch/sm13126247"/>
  <id>tag:nicovideo.jp,2010-12-25:/watch/sm13126247</id>
  <published>2010-12-25T18:52:35+09:00</published>
  <updated>2012-05-19T20:08:43+09:00</updated>
  <content type="html"><![CDATA[
    <div xmlns="http://www.w3.org/1999/xhtml">
      <p class="nico-thumbnail"><img alt="ゆっくり実況[Silent Hill Shattered Memories] Part 1" src="http://tn-skr4.smilevideo.jp/smile?i=13126247" width="94" height="70" border="0"/></p>
      <p class="nico-description">画質と字幕については改善に努力しています。すまんこPart　2→sm13129821　　　　mylist/22808808　　　同時進行[sm13238425][sm13188060]　　メール→neko</p>
      <p class="nico-info"><small><strong class="nico-info-length">14:20</strong>｜<strong class="nico-info-date">2010年12月25日 18：52：35</strong> 投稿</small></p>
    </div>
  ]]></content>
</entry>

</feed>
'''

describe "About TagSearchAtom class", ->
  describe "when create an instance with a video id", ->
    before (done) ->
      @searchPage = new NicoScraper.Source.TagSearchAtom xml
      done()

    it "has a mylist property", ->
      @searchPage.tags.should.include 'ゆっくり実況プレイpart1リンク'
      @searchPage.updated.should.equal '2012-05-19T22:10:25+09:00'

    it "has movies property in this mylist", ->
      @searchPage.entry['sm17854700'].title.should.equal '【ゆっくり実況】月風魔伝　その1'
      @searchPage.entry['sm17854700'].videoId.should.equal 'sm17854700'
      # @searchPage.entry['sm17854700'].timelike_id.should.equal
      @searchPage.entry['sm17854700'].thumbnailUrl.should.equal 'http://tn-skr1.smilevideo.jp/smile?i=17854700'
      @searchPage.entry['sm17854700'].description.should.equal '戻って参りました。頑張らせていただきます！月風魔伝ゆっくり実況まとめ→mylist/32058660単発まとめ→mylist/25326423シリーズ物part1まとめ→mylist/28984'
      @searchPage.entry['sm17854700'].length.should.equal 520
      @searchPage.entry['sm17854700'].infoDate.should.equal 1337330705
