//= require jquery
//= require tether
//= require bootstrap
//= require highlight.pack

$(function () {
  hljs.initHighlightingOnLoad();

  var root = document.getElementsByClassName ? document.getElementsByClassName('b-contents__wrapper')[0] : document.body;
  ya.yobject.load(root);
});
