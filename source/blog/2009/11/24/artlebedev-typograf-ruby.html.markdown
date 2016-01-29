---
date: 2009-11-24 06:06
title: Типограф студии Артемия Лебедева с отблеском Рубина
slug: artlebedev-typograf-ruby
type: post
tags: Ruby, Backend Development, Студия Артемия Лебедева, типографика, удобство
---

Понадобилось мне [типографировать тексты](http://www.artlebedev.ru/kovodstvo/sections/62/), добавляемые в админке одного из приложений. Поиск в интернете ни одного годного типографа на Ruby не показал.
Зато, я вспомнил, что студия Артемия Лебедева позволяет типографировать тексты с помощью их [веб-сервиса](http://www.artlebedev.ru/tools/typograf/webservice/). Поэтому, я написал [маленькую обёртку к их сервису](https://github.com/alsemyonov/als_typograf "AlsTypograf").

Пользоваться очень просто.

*   Установите:

    ``` bash
    gem install als_typograf
    ```

*   В коде приложения используйте метод `process` модуля `AlsTypograf` следующим образом:

    ``` ruby
    require 'als_typograf'
    AlsTypograf.process('- Это что, "Типограф"?') # "<p>— Это что, «Типограф»?</p>"
    ```

Обёртка поддерживает несколько опций, предоставляемых веб-сервисом Студии, их можно подставлять как к конкретному запросу:

``` ruby
AlsTypograf.process('- Это что, "Типограф"?', use_p: false, use_br: true)
```

так и выставлять глобально, для всех запросов на типографирование:

<pre><code class="ruby">AlsTypograf.encoding = 'CP1251' # По-умолчанию используется кодировка UTF-8
AlsTypograf.html_entities! # Заставляет использовать сущности HTML, такие как: &amp;nbsp;, &amp;mdash; &amp;hellip;</code></pre>

[Документация для рубинового типографа](http://www.rubydoc.info/github/alsemyonov/als_typograf) хранится (и автоматически обновляется при любых изменениях) на сервисе [rubydoc.info](http://www.rubydoc.info/), который весьма рекомендую всем разработчикам.
