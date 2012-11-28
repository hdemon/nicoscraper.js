var $, httpsync, _;

_ = require('underscore');

_.str = require('underscore.string');

_.mixin(_.str.exports());

_.str.include('Underscore.string', 'string');

$ = require('cheerio');

httpsync = require('httpsync');

var NicoScraper;

NicoScraper = {
  MylistAtom: {
    Entry: {}
  },
  Movie: {},
  Mylist: {}
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

  function Connection(uri) {
    var response;
    this.uri = uri;
    response = httpsync.get(this.uri).end();
    switch (response.statusCode) {
      case 200:
        return response.data.toString();
      case 404:
      case 500:
      case 503:
        return "";
    }
  }

  return Connection;

})();

var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

NicoScraper.MylistAtom.Entry = (function(_super) {

  __extends(Entry, _super);

  Entry.extend(NicoScraper.Utility);

  function Entry(body) {
    this.body = body;
  }

  Entry.prototype.content = function() {
    var _ref;
    return (_ref = this._content) != null ? _ref : this._content = this.body.find('content');
  };

  Entry.prototype.title = function() {
    var _ref;
    return (_ref = this._title) != null ? _ref : this._title = this.body.find('title').text();
  };

  Entry.prototype.videoId = function() {
    var _ref;
    return (_ref = this._videoId) != null ? _ref : this._videoId = this.body.find('link').attr('href').split('/')[4];
  };

  Entry.prototype.timelikeId = function() {
    var _ref;
    return (_ref = this._timelikeId) != null ? _ref : this._timelikeId = Number(this.body.find('id').text().split(',')[1].split(':')[1].split('/')[2]);
  };

  Entry.prototype.published = function() {
    var _ref;
    return (_ref = this._published) != null ? _ref : this._published = this.body.find('published').text();
  };

  Entry.prototype.updated = function() {
    var _ref;
    return (_ref = this._updated) != null ? _ref : this._updated = this.body.find('updated').text();
  };

  Entry.prototype.thumbnailUrl = function() {
    var _ref;
    return (_ref = this._thumbnailUrl) != null ? _ref : this._thumbnailUrl = this.content().find('img').attr('src');
  };

  Entry.prototype.description = function() {
    var _ref;
    return (_ref = this._description) != null ? _ref : this._description = this.content().find('.nico-description').text();
  };

  Entry.prototype.length = function() {
    var _ref;
    return (_ref = this._length) != null ? _ref : this._length = this._convertToSec(this.content().find('.nico-info-length').text());
  };

  Entry.prototype.infoDate = function() {
    var _ref;
    return (_ref = this._infoDate) != null ? _ref : this._infoDate = this._convertToUnixTime(this.content().find('.nico-info-date').text());
  };

  return Entry;

})(Module);

var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

NicoScraper.GetThumbInfo = (function(_super) {

  __extends(GetThumbInfo, _super);

  GetThumbInfo.extend(NicoScraper.Utility);

  function GetThumbInfo(id, scraped) {
    this.id = id;
    this.scraped = scraped != null ? scraped : false;
  }

  GetThumbInfo.prototype.body = function() {
    if (this._body != null) {
      return this._body;
    } else {
      this.scraped = true;
      return this._body = $(NicoScraper.Connection("http://ext.nicovideo.jp/api/getthumbinfo/" + this.id));
    }
  };

  GetThumbInfo.prototype.title = function() {
    var _ref;
    return (_ref = this._title) != null ? _ref : this._title = this.body().find('title').text();
  };

  GetThumbInfo.prototype.description = function() {
    var _ref;
    return (_ref = this._description) != null ? _ref : this._description = this.body().find('description').text();
  };

  GetThumbInfo.prototype.thumbnailUrl = function() {
    var _ref;
    return (_ref = this._thumbnailUrl) != null ? _ref : this._thumbnailUrl = this.body().find('thumbnail_url').text();
  };

  GetThumbInfo.prototype.firstRetrieve = function() {
    var _ref;
    return (_ref = this._firstRetrieve) != null ? _ref : this._firstRetrieve = this.body().find('first_retrieve').text();
  };

  GetThumbInfo.prototype.length = function() {
    var _ref;
    return (_ref = this._length) != null ? _ref : this._length = this._convertToSec(this.body().find('length').text());
  };

  GetThumbInfo.prototype.movieType = function() {
    var _ref;
    return (_ref = this._movieType) != null ? _ref : this._movieType = this.body().find('movie_type').text();
  };

  GetThumbInfo.prototype.sizeHigh = function() {
    var _ref;
    return (_ref = this._sizeHigh) != null ? _ref : this._sizeHigh = Number(this.body().find('size_high').text());
  };

  GetThumbInfo.prototype.sizeLow = function() {
    var _ref;
    return (_ref = this._sizeLow) != null ? _ref : this._sizeLow = Number(this.body().find('size_low').text());
  };

  GetThumbInfo.prototype.viewCounter = function() {
    var _ref;
    return (_ref = this._viewCounter) != null ? _ref : this._viewCounter = Number(this.body().find('view_counter').text());
  };

  GetThumbInfo.prototype.commentNum = function() {
    var _ref;
    return (_ref = this._commentNum) != null ? _ref : this._commentNum = Number(this.body().find('comment_num').text());
  };

  GetThumbInfo.prototype.Counter = function() {
    var _ref;
    return (_ref = this._mylistCounter) != null ? _ref : this._mylistCounter = Number(this.body().find('mylist_counter').text());
  };

  GetThumbInfo.prototype.lastResBody = function() {
    var _ref;
    return (_ref = this._lastResBody) != null ? _ref : this._lastResBody = this.body().find('last_res_body').text();
  };

  GetThumbInfo.prototype.watchUrl = function() {
    var _ref;
    return (_ref = this._watchUrl) != null ? _ref : this._watchUrl = this.body().find('watch_url').text();
  };

  GetThumbInfo.prototype.thumbType = function() {
    var _ref;
    return (_ref = this._thumbType) != null ? _ref : this._thumbType = this.body().find('thumb_type').eq(0).text();
  };

  GetThumbInfo.prototype.embeddable = function() {
    var _ref;
    return (_ref = this._embeddable) != null ? _ref : this._embeddable = Number(this.body().find('embeddable').text());
  };

  GetThumbInfo.prototype.noLivePlay = function() {
    var _ref;
    return (_ref = this._noLivePlay) != null ? _ref : this._noLivePlay = Number(this.body().find('no_live_play').text());
  };

  GetThumbInfo.prototype.tags = function() {
    var _ref;
    return (_ref = this._tags) != null ? _ref : this._tags = this._parseTags();
  };

  GetThumbInfo.prototype._parseTags = function() {
    var array;
    array = [];
    this.body().find('tag').each(function(i, e) {
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

var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

NicoScraper.Movie = (function() {

  function Movie(id, source) {
    this.id = id;
    this.source = source;
    this._mylistAtom = __bind(this._mylistAtom, this);

    this._getThumbInfo = __bind(this._getThumbInfo, this);

  }

  Movie.prototype.type = function() {
    if (_(this.id).startsWith('nm')) {
      return 'Niconico Movie Maker';
    } else if (_(this.id).startsWith('sm')) {
      return 'Smile Video';
    } else {
      return 'unknown';
    }
  };

  Movie.prototype.videoId = function() {
    if (this.type() !== 'unknown') {
      return this.id;
    }
  };

  Movie.prototype.threadId = function() {
    return this._source("threadId");
  };

  Movie.prototype.title = function() {
    return this._source("title");
  };

  Movie.prototype.description = function() {
    return this._source("description");
  };

  Movie.prototype.thumbnailUrl = function() {
    return this._source("thumbnailUrl");
  };

  Movie.prototype.firstRetrieve = function() {
    return this._source("firstRetrieve");
  };

  Movie.prototype.published = function() {
    return this._source("published");
  };

  Movie.prototype.updated = function() {
    return this._source("updated");
  };

  Movie.prototype.infoDate = function() {
    return this._source("infoDate");
  };

  Movie.prototype.length = function() {
    return this._source("length");
  };

  Movie.prototype.movieType = function() {
    return this._source("movieType");
  };

  Movie.prototype.sizeHigh = function() {
    return this._source("sizeHigh");
  };

  Movie.prototype.sizeLow = function() {
    return this._source("sizeLow");
  };

  Movie.prototype.viewCounter = function() {
    return this._source("viewCounter");
  };

  Movie.prototype.commentNum = function() {
    return this._source("commentNum");
  };

  Movie.prototype.mylistCounter = function() {
    return this._source("mylistCounter");
  };

  Movie.prototype.lastResBody = function() {
    return this._source("lastResBody");
  };

  Movie.prototype.watchUrl = function() {
    return this._source("watchUrl");
  };

  Movie.prototype.thumbType = function() {
    return this._source("thumbType");
  };

  Movie.prototype.embeddable = function() {
    return this._source("embeddable");
  };

  Movie.prototype.noLivePlay = function() {
    return this._source("noLivePlay");
  };

  Movie.prototype.tags = function() {
    return this._source("tags");
  };

  Movie.prototype._source = function(attr) {
    var gt, ma;
    gt = this._getThumbInfo();
    ma = this._mylistAtom();
    if (this.source != null) {
      return this.source[attr]();
    } else if ((gt[attr] != null) && (ma[attr] != null)) {
      if (gt.scraped != null) {
        return gt[attr]();
      } else if (ma.scraped != null) {
        return ma[attr]();
      } else {
        return gt[attr]();
      }
    } else if (gt[attr] != null) {
      return gt[attr]();
    } else if (ma[attr] != null) {
      return ma[attr]();
    }
  };

  Movie.prototype._getThumbInfo = function() {
    var _ref;
    return (_ref = this.__getThumbInfo) != null ? _ref : this.__getThumbInfo = new NicoScraper.GetThumbInfo(this.id);
  };

  Movie.prototype._mylistAtom = function() {
    var _ref;
    return (_ref = this.__mylistAtom) != null ? _ref : this.__mylistAtom = new NicoScraper.MylistAtom(this.id);
  };

  return Movie;

})();

var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

NicoScraper.Mylist = (function() {

  function Mylist(id) {
    this.id = id;
    this._mylistHtml = __bind(this._mylistHtml, this);

    this._mylistAtom = __bind(this._mylistAtom, this);

  }

  Mylist.prototype.type = function() {
    if (_(this.id).startsWith('nm')) {
      return 'Niconico Movie Maker';
    } else if (_(this.id).startsWith('sm')) {
      return 'Smile Video';
    } else {
      return 'unknown';
    }
  };

  Mylist.prototype.title = function() {
    return this._source("title");
  };

  Mylist.prototype.subTitle = function() {
    return this._source("subtitle");
  };

  Mylist.prototype.author = function() {
    return this._source("author");
  };

  Mylist.prototype.mylistId = function() {
    return this._source("mylistId");
  };

  Mylist.prototype.updatedTime = function() {
    return this._source("updated");
  };

  Mylist.prototype.movies = function() {
    var movie, movies, videoId, _ref;
    movies = {};
    _ref = this._source("movies");
    for (videoId in _ref) {
      movie = _ref[videoId];
      movies[videoId] = new NicoScraper.Movie(videoId, movie);
    }
    return movies;
  };

  Mylist.prototype.movie = function(id) {
    return this.movies()[id];
  };

  Mylist.prototype._source = function(attr) {
    var ma, mh;
    ma = this._mylistAtom();
    mh = this._mylistHtml();
    if ((ma[attr] != null) && (mh[attr] != null)) {
      if (ma.scraped != null) {
        return ma[attr]();
      } else if (mh.scraped != null) {
        return mh[attr]();
      } else {
        return ma[attr]();
      }
    } else if (ma[attr] != null) {
      return ma[attr]();
    } else if (mh[attr] != null) {
      return mh[attr]();
    }
  };

  Mylist.prototype._mylistAtom = function() {
    var _ref;
    return (_ref = this.__mylistAtom) != null ? _ref : this.__mylistAtom = new NicoScraper.MylistAtom(this.id);
  };

  Mylist.prototype._mylistHtml = function() {
    var _ref;
    return (_ref = this.__mylistAtom) != null ? _ref : this.__mylistAtom = new NicoScraper.MylistAtom(this.id);
  };

  return Mylist;

})();

var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

NicoScraper.MylistAtom = (function(_super) {

  __extends(MylistAtom, _super);

  MylistAtom.extend(NicoScraper.Utility);

  function MylistAtom(id, scraped) {
    this.id = id;
    this.scraped = scraped != null ? scraped : false;
  }

  MylistAtom.prototype.body = function() {
    if (this._body != null) {
      return this._body;
    } else {
      this.scraped = true;
      return this._body = $(NicoScraper.Connection("http://www.nicovideo.jp/mylist/" + this.id + "?rss=atom"));
    }
  };

  MylistAtom.prototype.title = function() {
    var _ref;
    return (_ref = this._title) != null ? _ref : this._title = this.body().find('title').eq(0).text().substring("マイリスト　".length).slice(0, -"‐ニコニコ動画".length);
  };

  MylistAtom.prototype.subtitle = function() {
    var _ref;
    return (_ref = this._subtitle) != null ? _ref : this._subtitle = this.body().find('subtitle').text();
  };

  MylistAtom.prototype.mylistId = function() {
    var _ref;
    return (_ref = this._mylistId) != null ? _ref : this._mylistId = Number(this.body().find('link').eq(0).attr('href').split('/')[4]);
  };

  MylistAtom.prototype.updated = function() {
    var _ref;
    return (_ref = this._updated) != null ? _ref : this._updated = this.body().find('updated').eq(0).text();
  };

  MylistAtom.prototype.author = function() {
    var _ref;
    return (_ref = this._author) != null ? _ref : this._author = this.body().find('author name').text();
  };

  MylistAtom.prototype.movies = function() {
    var _ref;
    return (_ref = this._movies) != null ? _ref : this._movies = this._entries();
  };

  MylistAtom.prototype._entries = function() {
    var entries, entry, _entry, _i, _len, _ref;
    entries = {};
    _ref = this.body().find('entry');
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      entry = _ref[_i];
      _entry = new NicoScraper.MylistAtom.Entry($(entry));
      entries[_entry.videoId()] = _entry;
    }
    return entries;
  };

  return MylistAtom;

})(Module);

NicoScraper.MylistAtom.Entry = (function(_super) {

  __extends(Entry, _super);

  Entry.extend(NicoScraper.Utility);

  function Entry(body) {
    this.body = body;
  }

  Entry.prototype.content = function() {
    var _ref;
    return (_ref = this._content) != null ? _ref : this._content = this.body.find('content');
  };

  Entry.prototype.title = function() {
    var _ref;
    return (_ref = this._title) != null ? _ref : this._title = this.body.find('title').text();
  };

  Entry.prototype.videoId = function() {
    var _ref;
    return (_ref = this._videoId) != null ? _ref : this._videoId = this.body.find('link').attr('href').split('/')[4];
  };

  Entry.prototype.timelikeId = function() {
    var _ref;
    return (_ref = this._timelikeId) != null ? _ref : this._timelikeId = Number(this.body.find('id').text().split(',')[1].split(':')[1].split('/')[2]);
  };

  Entry.prototype.published = function() {
    var _ref;
    return (_ref = this._published) != null ? _ref : this._published = this.body.find('published').text();
  };

  Entry.prototype.updated = function() {
    var _ref;
    return (_ref = this._updated) != null ? _ref : this._updated = this.body.find('updated').text();
  };

  Entry.prototype.thumbnailUrl = function() {
    var _ref;
    return (_ref = this._thumbnailUrl) != null ? _ref : this._thumbnailUrl = this.content().find('img').attr('src');
  };

  Entry.prototype.description = function() {
    var _ref;
    return (_ref = this._description) != null ? _ref : this._description = this.content().find('.nico-description').text();
  };

  Entry.prototype.length = function() {
    var _ref;
    return (_ref = this._length) != null ? _ref : this._length = this._convertToSec(this.content().find('.nico-info-length').text());
  };

  Entry.prototype.infoDate = function() {
    var _ref;
    return (_ref = this._infoDate) != null ? _ref : this._infoDate = this._convertToUnixTime(this.content().find('.nico-info-date').text());
  };

  return Entry;

})(Module);


NicoScraper.tag = function(keyword, callback) {
  var continueOrder, movies, succ, tag, _results;
  tag = new NicoScraper.TagSearch(keyword);
  movies = tag.movies();
  succ = function() {
    if (_.isEmpty(movies)) {
      movies = tag.nextPage().movies();
    }
    return movies.shift();
  };
  _results = [];
  while (continueOrder === true) {
    _results.push(continueOrder = callback(succ()));
  }
  return _results;
};

NicoScraper.tag = function(keyword, callback) {
  var continueOrder, movies, succ, tag, _results;
  tag = new NicoScraper.TagSearch(keyword);
  movies = tag.movies();
  succ = function() {
    if (_.isEmpty(movies)) {
      movies = tag.nextPage().movies();
    }
    return movies.shift();
  };
  continueOrder = true;
  _results = [];
  while (continueOrder === true) {
    _results.push(continueOrder = callback(succ()));
  }
  return _results;
};

var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

NicoScraper.TagSearch = (function() {

  function TagSearch(keyword) {
    this.keyword = keyword;
    this._tagSearch = __bind(this._tagSearch, this);

    this._tagSearchAtom = __bind(this._tagSearchAtom, this);

  }

  TagSearch.prototype.movies = function() {
    var movie, movies, videoId, _ref;
    movies = [];
    _ref = this._source("movies");
    for (videoId in _ref) {
      movie = _ref[videoId];
      movies.push(new NicoScraper.Movie(videoId, movie));
    }
    return movies;
  };

  TagSearch.prototype.movie = function(id) {
    return this.movies()[id];
  };

  TagSearch.prototype.nextPage = function() {
    this.__tagSearchAtom.next();
    return this;
  };

  TagSearch.prototype.prevPage = function() {
    this.__tagSearchAtom.prev();
    return this;
  };

  TagSearch.prototype._source = function(attr) {
    if (this._tagSearchAtom().scraped && (this._tagSearchAtom()[attr] != null)) {
      this._tagSearchAtom()[attr]();
    }
    if (this._tagSearch().scraped && (this._tagSearch()[attr] != null)) {
      this._tagSearch()[attr]();
    }
    if (this._tagSearchAtom()[attr] != null) {
      this._tagSearchAtom()[attr]();
    }
    if (this._tagSearch()[attr] != null) {
      return this._tagSearch()[attr]();
    }
  };

  TagSearch.prototype._tagSearchAtom = function() {
    var _ref;
    return (_ref = this.__tagSearchAtom) != null ? _ref : this.__tagSearchAtom = new NicoScraper.TagSearchAtom(this.keyword, {
      page: this._page
    });
  };

  TagSearch.prototype._tagSearch = function() {
    var _ref;
    return (_ref = this.__tagSearchAtom) != null ? _ref : this.__tagSearchAtom = new NicoScraper.TagSearchAtom(this.keyword, {
      page: this._page
    });
  };

  return TagSearch;

})();

var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

NicoScraper.TagSearchAtom = (function(_super) {

  __extends(TagSearchAtom, _super);

  TagSearchAtom.extend(NicoScraper.Utility);

  function TagSearchAtom(keyword, options) {
    this.keyword = keyword;
    this.options = options != null ? options : {};
    this._cache = {};
    this.options = {
      page: 1,
      sort: 'newness_of_comment',
      order: 'desc'
    };
    this.page = this.options.page;
  }

  TagSearchAtom.prototype.next = function() {
    this.page += 1;
    return this._cache = {};
  };

  TagSearchAtom.prototype.prev = function() {
    this.page -= 1;
    return this._cache = {};
  };

  TagSearchAtom.prototype.uri = function() {
    return ("http://www.nicovideo.jp/tag/" + this.keyword + "?") + this._queryParam();
  };

  TagSearchAtom.prototype.body = function() {
    if (this._cache.body != null) {
      return this._cache.body;
    } else {
      this.scraped = true;
      return this._cache.body = $(NicoScraper.Connection(this.uri()));
    }
  };

  TagSearchAtom.prototype.movies = function() {
    var _base, _ref;
    return (_ref = (_base = this._cache).movies) != null ? _ref : _base.movies = this._entries();
  };

  TagSearchAtom.prototype._queryParam = function() {
    var param;
    param = [];
    param.push(this._pageParam());
    if (this._sortParam() != null) {
      param.push(this._sortParam());
    }
    if (this._orderParam() != null) {
      param.push(this._orderParam());
    }
    param.push('rss=atom');
    return param.join('&');
  };

  TagSearchAtom.prototype._pageParam = function() {
    return "page=" + this.page;
  };

  TagSearchAtom.prototype._sortParam = function() {
    switch (this.options.sort) {
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

  TagSearchAtom.prototype._orderParam = function() {
    switch (this.options.order) {
      case 'asc':
        return 'order=a';
      case 'desc':
        return null;
    }
  };

  TagSearchAtom.prototype._entries = function() {
    var entries, entry, _entry, _i, _len, _ref;
    entries = {};
    _ref = this.body().find('entry');
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      entry = _ref[_i];
      _entry = new NicoScraper.MylistAtom.Entry($(entry));
      entries[_entry.videoId()] = _entry;
    }
    return entries;
  };

  return TagSearchAtom;

})(Module);

NicoScraper.TagSearchAtom.Entry = (function(_super) {

  __extends(Entry, _super);

  Entry.extend(NicoScraper.Utility);

  function Entry(body) {
    this.body = body;
  }

  Entry.prototype.content = function() {
    var _base, _ref;
    return (_ref = (_base = this._cache).content) != null ? _ref : _base.content = this.body.find('content');
  };

  Entry.prototype.title = function() {
    var _base, _ref;
    return (_ref = (_base = this._cache).title) != null ? _ref : _base.title = this.body.find('title').text();
  };

  Entry.prototype.videoId = function() {
    var _base, _ref;
    return (_ref = (_base = this._cache).videoId) != null ? _ref : _base.videoId = this.body.find('link').attr('href').split('/')[4];
  };

  Entry.prototype.timelikeId = function() {
    var _base, _ref;
    return (_ref = (_base = this._cache).timelikeId) != null ? _ref : _base.timelikeId = Number(this.body.find('id').text().split(',')[1].split(':')[1].split('/')[2]);
  };

  Entry.prototype.published = function() {
    var _base, _ref;
    return (_ref = (_base = this._cache).published) != null ? _ref : _base.published = this.body.find('published').text();
  };

  Entry.prototype.updated = function() {
    var _base, _ref;
    return (_ref = (_base = this._cache).updated) != null ? _ref : _base.updated = this.body.find('updated').text();
  };

  Entry.prototype.thumbnailUrl = function() {
    var _base, _ref;
    return (_ref = (_base = this._cache).thumbnailUrl) != null ? _ref : _base.thumbnailUrl = this.content().find('img').attr('src');
  };

  Entry.prototype.description = function() {
    var _base, _ref;
    return (_ref = (_base = this._cache).description) != null ? _ref : _base.description = this.content().find('.nico-description').text();
  };

  Entry.prototype.length = function() {
    var _base, _ref;
    return (_ref = (_base = this._cache).length) != null ? _ref : _base.length = this._cache.convertToSec(this.content().find('.nico-info-length').text());
  };

  Entry.prototype.infoDate = function() {
    var _base, _ref;
    return (_ref = (_base = this._cache).infoDate) != null ? _ref : _base.infoDate = this._cache.convertToUnixTime(this.content().find('.nico-info-date').text());
  };

  return Entry;

})(Module);


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
