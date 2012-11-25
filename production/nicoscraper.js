var $, request, _;

_ = require('underscore');

_.str = require('underscore.string');

_.mixin(_.str.exports());

_.str.include('Underscore.string', 'string');

$ = require('cheerio');

request = require('request');

var NicoScraper;

NicoScraper = {
  Source: {}
};

var Module, moduleKeywords,
  __indexOf = [].indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };

moduleKeywords = ['extended', 'included'];

Module = (function() {

  function Module() {}

  Module.extend = function(obj) {
    var key, value;
    for (key in obj) {
      value = obj[key];
      if (__indexOf.call(moduleKeywords, key) < 0) {
        this[key] = value;
      }
    }
    return this;
  };

  Module.include = function(obj) {
    var key, value;
    for (key in obj) {
      value = obj[key];
      if (__indexOf.call(moduleKeywords, key) < 0) {
        this.prototype[key] = value;
      }
    }
    return this;
  };

  return Module;

})();


NicoScraper.Connection = (function() {

  function Connection(uri, callback) {
    var request, _base, _base1, _ref, _ref1,
      _this = this;
    this.uri = uri;
    this.callback = callback;
    if ((_ref = (_base = this.callback).success) == null) {
      _base.success = function() {};
    }
    if ((_ref1 = (_base1 = this.callback).failed) == null) {
      _base1.failed = function() {};
    }
    request = new request;
    request(this.uri, function(error, response, body) {
      switch (response.statusCode) {
        case 200:
          return _this.callback.success(body);
        case 404:
          _this.callback.failed;
          return _this.callback._404;
        case 500:
          _this.callback.failed;
          return _this.callback._500;
        case 503:
          _this.callback.failed;
          return _this.callback._503;
      }
    });
  }

  return Connection;

})();

var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

NicoScraper.Source.EntryAtom = (function(_super) {

  __extends(EntryAtom, _super);

  EntryAtom.extend(NicoScraper.Utility);

  function EntryAtom(body) {
    this.body = body;
    this.b = $(this.body);
    this.c = this.b.find('content');
    this.title = this.b.find('title').text();
    this.videoId = this.b.find('link').attr('href').split('/')[4];
    this.timelikeId = Number(this.b.find('id').text().split(',')[1].split(':')[1].split('/')[2]);
    this.published = this.b.find('published').text();
    this.updated = this.b.find('updated').text();
    this.thumbnailUrl = this.c.find('img').attr('src');
    this.description = this.c.find('.nico-description').text();
    this.length = this._convertToSec(this.c.find('.nico-info-length').text());
    this.infoDate = this._convertToUnixTime(this.c.find('.nico-info-date').text());
  }

  return EntryAtom;

})(Module);

module.exports = NicoScraper.EntryAtom;

var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

NicoScraper.Source.GetThumbInfo = (function(_super) {

  __extends(GetThumbInfo, _super);

  GetThumbInfo.extend(NicoScraper.Utility);

  function GetThumbInfo(xml) {
    var b;
    this.xml = xml;
    b = $(this.xml).find('thumb');
    this.title = b.find('title').text();
    this.description = b.find('description').text();
    this.thumbnailUrl = b.find('thumbnail_url').text();
    this.firstRetrieve = b.find('first_retrieve').text();
    this.length = this._convertToSec(b.find('length').text());
    this.movieType = b.find('movie_type').text();
    this.sizeHigh = Number(b.find('size_high').text());
    this.sizeLow = Number(b.find('size_low').text());
    this.viewCounter = Number(b.find('view_counter').text());
    this.commentNum = Number(b.find('comment_num').text());
    this.mylistCounter = Number(b.find('mylist_counter').text());
    this.lastResBody = b.find('last_res_body').text();
    this.watchUrl = b.find('watch_url').text();
    this.thumbType = b.find('thumb_type').eq(0).text();
    this.embeddable = Number(b.find('embeddable').text());
    this.noLivePlay = Number(b.find('no_live_play').text());
    this.tags = this._parseTags();
  }

  GetThumbInfo.prototype._parseTags = function() {
    var xml, xmlJp, xmlTw;
    xml = $(this.xml);
    xmlJp = xml.find('tags[domain=jp]');
    xmlTw = xml.find('tags[domain=tw]');
    return {
      'jp': this._objectize(xmlJp),
      'tw': this._objectize(xmlTw)
    };
  };

  GetThumbInfo.prototype._objectize = function(xml) {
    var array;
    array = [];
    xml.find('tag').each(function(i, e) {
      var category, lock, obj;
      e = $(e);
      obj = {
        string: e.text()
      };
      category = e.attr('category');
      lock = e.attr('lock');
      if (!_.isEmpty(category)) {
        _.extend(obj, {
          category: Number(category)
        });
      }
      if (!_.isEmpty(lock)) {
        _.extend(obj, {
          lock: Number(lock)
        });
      }
      return array.push(obj);
    });
    return array;
  };

  return GetThumbInfo;

})(Module);


NicoScraper.Movie = (function() {

  function Movie(provisional_id) {
    this.provisional_id = provisional_id;
    this.source = {
      getThumbInfo: {},
      mylistAtom: {},
      mylistHtml: {},
      html: {}
    };
  }

  Movie.prototype.getAtom = function(callback) {
    var connection,
      _this = this;
    return connection = new NicoScraper.Connection(this.uri + "?rss=atom", {
      success: function(browser) {
        _this.source.getThumbInfo = new NicoScraper.Source.GetThumbInfo(browser.window.document.innerHTML);
        return callback(_this);
      }
    });
  };

  Movie.prototype.getType = function() {
    switch (_.startsWith(this.provisional_id)) {
      case 'nm':
        return 'Niconico Movie Maker';
      case 'sm':
        return 'Smile Video';
      default:
        return 'unknown';
    }
  };

  Movie.prototype.videoId = function() {
    return this.provisional_id || this.source.mylistAtom.videoId;
  };

  Movie.prototype.threadId = function() {
    return this.source.mylistAtom.threadId;
  };

  Movie.prototype.title = function() {
    return this.source.getThumbInfo.title || this.source.mylistAtom.title;
  };

  Movie.prototype.description = function() {
    return this.source.getThumbInfo.description || this.source.mylistAtom.description;
  };

  Movie.prototype.thumbnailUrl = function() {
    return this.source.getThumbInfo.thumbnailUrl || this.source.mylistAtom.thumbnailUrl;
  };

  Movie.prototype.firstRetrieve = function() {
    return this.source.getThumbInfo.firstRetrieve;
  };

  Movie.prototype.published = function() {
    return this.source.getThumbInfo.published;
  };

  Movie.prototype.updated = function() {
    return this.source.getThumbInfo.updated;
  };

  Movie.prototype.infoDate = function() {
    return this.source.getThumbInfo.infoDate;
  };

  Movie.prototype.length = function() {
    return this.source.getThumbInfo.length || this.source.mylistAtom.length;
  };

  Movie.prototype.movieType = function() {
    return this.source.getThumbInfo.movieType;
  };

  Movie.prototype.sizeHigh = function() {
    return this.source.getThumbInfo.sizeHigh;
  };

  Movie.prototype.sizeLow = function() {
    return this.source.getThumbInfo.sizeLow;
  };

  Movie.prototype.viewCounter = function() {
    return this.source.getThumbInfo.viewCounter;
  };

  Movie.prototype.commentNum = function() {
    return this.source.getThumbInfo.commentNum;
  };

  Movie.prototype.mylistCounter = function() {
    return this.source.getThumbInfo.mylistCounter;
  };

  Movie.prototype.lastResBody = function() {
    return this.source.getThumbInfo.lastResBody;
  };

  Movie.prototype.watchUrl = function() {
    return this.source.getThumbInfo.watchUrl;
  };

  Movie.prototype.thumbType = function() {
    return this.source.getThumbInfo.thumbType;
  };

  Movie.prototype.embeddable = function() {
    return this.source.getThumbInfo.embeddable;
  };

  Movie.prototype.noLivePlay = function() {
    return this.source.getThumbInfo.noLivePlay;
  };

  return Movie;

})();


NicoScraper.Mylist = (function() {

  function Mylist(mylist_id) {
    this.mylist_id = mylist_id;
    this.uri = "http://www.nicovideo.jp/mylist/" + this.mylist_id;
    this.source = {
      atom: {},
      html: {}
    };
  }

  Mylist.prototype.getAtom = function(callback) {
    var connection,
      _this = this;
    return connection = new NicoScraper.Connection(this.uri + "?rss=atom", {
      success: function(browser) {
        _this.source.atom = new NicoScraper.Source.MylistAtom(browser.window.document.innerHTML);
        console.log("callback");
        return callback(_this);
      }
    });
  };

  Mylist.prototype.getHtml = function() {};

  Mylist.prototype.title = function() {
    return this.source.atom.title;
  };

  Mylist.prototype.subtitle = function() {
    return this.source.atom.subtitle;
  };

  Mylist.prototype.author = function() {
    return this.source.atom.author;
  };

  Mylist.prototype.mylistId = function() {
    return this.source.atom.mylistId;
  };

  Mylist.prototype.updatedTime = function() {
    return this.source.atom.updated;
  };

  Mylist.prototype.movies = function() {};

  return Mylist;

})();


NicoScraper.Source.MylistAtom = (function() {

  function MylistAtom(xml) {
    var e, entry, _i, _len, _ref;
    this.xml = xml;
    this.entry = {};
    _ref = $(this.xml).find('entry');
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      entry = _ref[_i];
      e = new NicoScraper.Source.EntryAtom(entry);
      this.entry[e.videoId] = e;
    }
    this.b = $(this.xml);
    this.title = this.b.find('title').eq(0).text().substring("マイリスト　".length).slice(0, -"‐ニコニコ動画".length);
    this.subtitle = this.b.find('subtitle').text();
    this.mylistId = Number(this.b.find('link').eq(0).attr('href').split('/')[4]);
    this.updated = this.b.find('updated').eq(0).text();
    this.author = this.b.find('author name').text();
    delete this.b;
  }

  return MylistAtom;

})();


NicoScraper.TagSearch = (function() {

  function TagSearch(params, callback) {
    var connection,
      _this = this;
    this.params = params != null ? params : {};
    this.callback = callback;
    this.page = this.params.page || 1;
    this.searchString = this.params.searchString || '';
    this.params.sortMethod = 'newness_of_comment';
    this.params.orderParam = 'desc';
    connection = new NicoScraper.Connection(this.uri(), {
      success: function(browser) {
        var info;
        info = new TagSearchAtom(browser.window.document.innerHTML);
        return _this.callback(info);
      }
    });
  }

  TagSearch.prototype.uri = function() {
    return this.host() + this.path() + '?' + this.queryParam();
  };

  TagSearch.prototype.host = function() {
    return 'http://www.nicovideo.jp/';
  };

  TagSearch.prototype.path = function() {
    return "tag/" + this.searchString;
  };

  TagSearch.prototype.queryParam = function() {
    var param;
    param = [];
    param.push(pageParam());
    if (sortParam() != null) {
      param.push(sortParam());
    }
    if (orderParam() != null) {
      param.push(orderParam());
    }
    param.push('rss=atom');
    return param.join('&');
  };

  TagSearch.prototype.next = function() {
    return this.page += 1;
  };

  TagSearch.prototype.prev = function() {
    return this.page -= 1;
  };

  TagSearch.prototype.pageParam = function() {
    return "page=" + this.page;
  };

  TagSearch.prototype.sortParam = function() {
    switch (this.params.sortMethod) {
      case 'newness_of_comment':
        return null;
      case 'view_num':
        return 'sort=v';
      case 'comment_num':
        return 'sort=r';
      case 'mylist_num':
        return 'sort=m';
      case 'published_date':
        return 'sort=f';
      case 'length':
        return 'sort=l';
    }
  };

  TagSearch.prototype.orderParam = function() {
    switch (this.params.orderParam) {
      case 'asc':
        return 'order=a';
      case 'desc':
        return null;
    }
  };

  return TagSearch;

})();


NicoScraper.Source.TagSearchAtom = (function() {

  function TagSearchAtom(xml) {
    var e, entry, _i, _len, _ref;
    this.xml = xml;
    this.entry = {};
    _ref = $(this.xml).find('entry');
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      entry = _ref[_i];
      e = new NicoScraper.Source.EntryAtom(entry);
      this.entry[e.videoId] = e;
    }
    this.b = $(this.xml);
    this.title = this.b.find('title').eq(0).text().substring("マイリスト　".length).slice(0, -"‐ニコニコ動画".length);
    this.subtitle = this.b.find('subtitle').text();
    this.updated = this.b.find('updated').eq(0).text();
    this.tags = this.b.find('title').eq(0).text().substring("タグ ".length).slice(0, -"‐ニコニコ動画".length).split(" ");
    delete this.b;
  }

  return TagSearchAtom;

})();


NicoScraper.Utility = (function() {

  function Utility() {}

  Utility.prototype._convertToSec = function(string) {
    var minute, s, second;
    s = string.split(':');
    minute = Number(s[0]);
    second = Number(s[1]);
    return minute * 60 + second;
  };

  Utility.prototype._convertToUnixTime = function(string) {
    var s;
    s = string.match(/\w+/g);
    return new Date(s[0], s[1] - 1, s[2], s[3], s[4], s[5], 0) / 1000;
  };

  return Utility;

})();


module.exports = NicoScraper;