(function() {
  var $, Zombie, browser, window, zombie;

  $ = require('jquery');

  Zombie = require('zombie');

  zombie = new Zombie;

  zombie.runScripts = false;

  browser = null;

  window = null;

  zombie.visit("http://www.nicovideo.jp/watch/sm10662973", function(e, br, status) {
    browser = br;
    browser.window.$ = $;
    window = browser.window;
    console.log($(browser.window.document).find('div'));
    window.onload();
   // return console.log($('div'));
  });

}).call(this);
