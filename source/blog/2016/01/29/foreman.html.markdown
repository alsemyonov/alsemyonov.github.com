---
layout: post
title: Управление процессами веб-приложения с помощью Foreman
date: 2016-01-29
tags: Foreman, gem, Backend Development, Deployment, Upstart, Ubuntu
category: Development
author: Alex Semyonov
published: false
---

## Foreman

`foreman` — утилита командной строки c [открытым исходным кодом][github], распространяемая в виде [гема][gem]

### Описание процессов

#### `Procfile`

Файл состоит из строк-описаний каждого процесса, который необходимо запустить для полноценного старта вашего приложения.
Все процессы запускаются из одной исходной директории, от имени одного и того же пользователя.

Описание процесса выглядит как:

``` yaml
name: ./bin/executable --option value argument
```

то есть имя процесса и команда, запускающяя его, разделённые двоеточием.

### Запуск

### Конкуренция

### Экспорт

### Deployment

### Полезные ссылки:

1. [Статья “Introducing Foreman”][getting_started] от создателя утилиты [David Dollar][]
1. [Документация CLI `foreman`][foreman] в формате Man Page
1. [Исходный код Foreman на Github][github]
1. [Домашняя страница гема `foreman`][gem]

[foreman]: http://ddollar.github.io/foreman/ "Foreman Manual" target="_blank"
[github]: https://github.com/ddollar/foreman "ddollar/foreman" target="_blank"
[gem]: https://rubygems.org/gems/foreman "foreman Ruby Gem" target="_blank"
[getting_started]: http://blog.daviddollar.org/2011/05/06/introducing-foreman.html "“Introducing Foreman” by David Dollar" (target="_blank")
[David Dollar]: http://david.dollar.io/ "Homepage of David Dollar" target="_blank"
[David Dollar Blog]: http://blog.daviddollar.org/ "David Dollar" target="_blank"
