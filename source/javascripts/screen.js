//= require jquery
//= require tether
//= require bootstrap
//= require highlight.pack

$(function () {
  hljs.initHighlightingOnLoad();

  var root = document.getElementsByClassName ? document.getElementsByClassName('b-contents__wrapper')[0] : document.body;
  ya.yobject.load(root, { domainSearch: 'https://al.semyonov.us/search/?searchid=2252973&text={0}&web=0' });

  var yaBrowserUpdater = new ya.browserUpdater.init({
    "lang": "ru",
    "browsers": {
      "yabrowser": "15.12",
      "chrome": "48",
      "ie": "10",
      "opera": "34",
      "safari": "8",
      "fx": "43",
      "amigo": "Infinity",
      "iron": "35",
      "flock": "Infinity",
      "palemoon": "25",
      "camino": "Infinity",
      "maxthon": "4.5",
      "seamonkey": "2.3"
    },
    "theme": "yellow"
  });
});
