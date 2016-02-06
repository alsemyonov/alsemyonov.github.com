---
date: 2009-04-01 06:06
title: Совместное использование Cucumber и Factory_Girl или роковая ошибка create_time_zone_conversion_attribute?
slug: using-cucumber-with-fatory_girl-or-create_time_zone_conversion_attribute-epic-fail
type: post
tags: Cucumber, Factory Girl, Ruby on Rails
category: Backend Development
---

Недавно открыл для себя <a title="Cucumber — making BDD fun!" href="http://cukes.info/">Cucumber</a> — утилиту для описания поведения вашего приложения. Весьма хорошая штука, доложу вам. Но о ней конкретно я расскажу как-нибудь потом.

Ещё я использую вместо стендовых данных (известных также как fixtures) замечательный гем от <a href="http://thoughtbot.com/">ThoughtBot</a> под названием <a href="http://thoughtbot.com/projects/factory_girl">Factory Girl</a> — он позволяет делать «заготовки» моделей и ваще очень крут (о нём — как вы, может быть, уже догадались — тоже в другой раз).

Но вот соединить их при тестировании одного проекта оказалось не так-то просто! При тестировании функционала каждый сценарий, начиная со второго использования метода Factory.create вылетал с ошибкой. Как показал бэктрэйс — ошибка случалась в функции ActiveRecord::Base.create_time_zone_conversion_attribute? Гугл рассказал мне, что разработчики рельсов <a href="https://rails.lighthouseapp.com/projects/8994/tickets/785-caching-models-fails-in-development">решают эту проблему</a> уже <a href="https://rails.lighthouseapp.com/projects/8994/tickets/1339">очень долго</a>, и хотя <a href="https://rails.lighthouseapp.com/attachments/60054/prevent_class_method_and_variable_nukeing_on_AR_reset_subclasses.diff">патч, решающий её</a>, давно найден — всё никак не вольют его в основной код. И на то есть веские причины, а именно — утечка <del>мозгов</del> <ins>памяти</ins> в production-режиме.

Тем не менее, при тестировании функционала эта утечка памяти не так критична, потому как тестовый сервер Cucumber'а запускается и останавливается регулярно — при каждом прогоне, а сервер приложения висит довольно долго и может отъесть довольно большой кусок памяти и подавиться им. Ну, надоели вступительные слова, вот…
<h2>…решение проблемы:</h2>
Необходимо поместить в директорию <code>lib</code> файл <code>activerecord_reset_sublass_fix.rb</code>, а так же добавить его вызов в файл <code>config/environments/test.rb</code> <a title="fix for create_time_zone_conversion_attribute? problem" href="http://gist.github.com/88826">следующим образом</a>:
<script src="http://gist.github.com/88826.js" type="text/javascript"></script>
