//= require jquery
//= require tether
//= require bootstrap
//= require highlight.pack

$(function () {
  hljs.initHighlightingOnLoad();

  var root = document.getElementsByClassName ? document.getElementsByClassName('b-contents__wrapper')[0] : document.body;
  ya.yobject.load(root, { domainSearch: 'https://al.semyonov.us/search/?searchid=2252973&text={0}&web=0' });
});
