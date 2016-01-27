---
date: 2008-09-11 03:03
title: Неделя на Рельсах (выпуск от 10 сентября 2008 г.)
slug: this-week-in-rails-september-10-2008-in-russian
type: post
tags: Ruby, Ruby on Rails, This Week in Rails, Переводы
---

Перевод. Оригинальная статья: <a href="http://weblog.rubyonrails.com/2008/9/10/this-week-in-rails-september-10-2008">This Week in Rails (September 10, 2008)</a>, за авторством Gregg Pollack

Добро пожаловать в пятый выпуск «Недели на рельсах», еженедельный отчёт о событиях в околорельсовом сообществе. Antonio Cangiano (автор идеи) был <a href="http://antoniocangiano.com/2008/09/09/a-status-update/">весьма занят</a>, поэтому на этой неделе я решил его подменить.

Вы, скорее всего, уже слышали о выходе <a href="http://weblog.rubyonrails.org/2008/9/3/rails-2-0-4-maintenance-release">Rails 2.0.4</a> и <a href="http://weblog.rubyonrails.org/2008/9/5/rails-2-1-1-lots-of-bug-fixes">Rails 2.1.1</a>. Оба релиза — в основном исправляют ошибки, за подробностями отправляйтесь в списки изменений.

<!--more-->

Если ваше приложение на Рельсах использует много тяжёлых SQL запросов, вы скорее всего захотите взглянуть на плагин от Fernando Blat, называемый <a href="http://www.inwebwetrust.net/post/2008/09/08/query-memcached">Query memcached</a>. Этот плагин замещает стандартную функциональность Рельсов по кешированию результатов запросов к базе, сохраняя их в memcached для использования в последующих запросах.

Вы когда-нибудь пытались реализовать «продвинутый поиск» в приложении на Рельсах? И скорее всего, ваши контроллеры от этого весьма разжирели. Одно из решений этой проблемы — <a href="http://www.binarylogic.com/2008/9/1/searchgasm-released">Searchgasm</a> от Binary Logic — плагин, объектно-ориентированная обёртка вокруг запроса к базе, благодаря которой код ваших контроллеров останется простым и коротким.

Ryan Daigle рассказал нам о новых фишках, введённых в новейших ревизиях кода Рельс: <a href="http://ryandaigle.com/articles/2008/9/7/what-s-new-in-edge-rails-connection-pools">Connection Pooling</a> (количество соединений с базой данных), <a href="http://ryandaigle.com/articles/2008/9/7/what-s-new-in-edge-rails-shallow-routes">Shallow Routes</a> («уплощение» маршрутов к вложенным ресурсам), а так же <a href="http://ryandaigle.com/articles/2008/9/7/what-s-new-in-edge-rails-mailer-layouts">Mailer Layouts</a> («обёртки» для сообщений электронной почты). Совсем скоро мы увидим кандидата в релиз Рельс 2.2, поэтому следите за новостями.

Для ваших друзей Java-программистов, использующих <a href="http://db.apache.org/derby/">Apache Derby</a>, которые хотят опробовать JRuby, Michael Galpin написал <a href="http://www.ibm.com/developerworks/opensource/library/os-ad-prototype-jruby/index.html?ca=dgr-btw01os-ad-prototype-jruby&amp;S_TACT=105AGX59&amp;S_CMP=GRsitebtw01">введение в Рельсы с использованием JRuby и Derby</a>.

На прошлой неделе Last week Mark Imbriaco из компании 37 Signals объединил собрал отличную статью и скринкаст о том, как они используют <a href="http://www.37signals.com/svn/posts/1073-nuts-bolts-haproxy">HAProxy на сервере</a>. Если вы ещё не в курсе преимуществ использования HAProxy перед apache round robin load balancer, обязательно посмотрите скринкаст.

Возможно, вы стали использовать jQuery вместо Prototype в Рельсовых приложениях. Вы могли использовать для этого плагин (например, <a href="http://ennerchi.com/projects/jrails">jQuery on Rails</a>), но если вы начали с нуля, то наверняка заработали много проблем с отправкой отметок аутентификации (authenticity tokens) в ваших <span class="caps">AJAX</span>-запросах. Lawrence Pit описал <a href="http://blog.lawrencepit.com/2008/09/04/unobtrusive-jquery-rails/">код jQuery, который вам необходим</a> чтобы избежать дальнейших проблем.

<a href="http://www.espace.com.eg/neverblock/">Neverblock</a> — это библиотека, которая позволяет использовать Нити Ruby (Ruby Fibers) для записи не-блокирующего конкуррентного кода. В рамках этого проекта недавно был выпущен <a href="http://www.espace.com.eg/neverblock/blog/2008/08/24/neverblock-and-activerecord-concurrent-db-access-without-threads/">не блокирующий адаптер PostgreSQL</a>, <a href="http://www.espace.com.eg/neverblock/blog/2008/08/28/neverblock-mysql-support/">не блокирующий адаптер MySQL</a>, и совсем недавно библиотеку для использования их Нитей <a href="http://www.espace.com.eg/neverblock/blog/2008/09/04/neverblock-instant-scaling-for-your-rails-apps/">на Ruby 1.8 совместно с Рельсами</a> с ошеломляющими результатами тестов производительности! Этот проект очень молод, однако это ещё один шаг к безопасным мульти-поточным Рельсам.

Наконец, я хочу рассказать о нескольких событиях. <a href="http://rubydcamp.org/">Ruby DCamp</a> состоится 11-12-го октября в Арлингтоне, <a href="http://site.locaweb.com.br/railssummit/?language=7">Rails Summit Latin America</a> будет проходить 15-го и 16-го октября в Сан-Пауло, в Бразилии, а также <a href="http://scrubyconf.colaruby.org/">South Carolina Ruby Conference</a> пройдёт 18-го октября в Колумбии.

Спасибо за чтение! Если вы предпочитаете слушать эти новости (с незначительными уточнениями), обратите внимание на <a href="http://www.railsenvy.com/2008/9/10/rails-envy-podcast-episode-046-09-10-2008">подкаст № 46 Rails Envy</a>, который вышел сегодня. Это не ошибка, что подкаст охватывает ту же информацию, что и данная статья, потому что я принимал участие в его создании.
