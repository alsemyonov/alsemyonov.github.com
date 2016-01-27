---
date: 2009-11-24 06:06
title: Типограф студии Артемия Лебедева с отблеском Рубина
slug: artlebedev-typograf-ruby
type: post
tags: Ruby, программирование, Студия Артемия Лебедева, типографика, удобство
---

Понадобилось мне <a href="http://www.artlebedev.ru/kovodstvo/sections/62/">типографировать тексты</a>, добавляемые в админке одного из приложений. Поиск в интернете ни одного годного типографа на Ruby не показал.
Зато, я вспомнил, что студия Артемия Лебедева позволяет типографировать тексты с помощью их <a href="http://www.artlebedev.ru/tools/typograf/webservice/">веб-сервиса</a>. Поэтому, я написал <a title="AlsTypograf" href="http://github.com/rotuka/als_typograf">маленькую обёртку к их сервису</a>.

Пользоваться очень просто.
<ol>
	<li>Установите:
<pre><code class="bash">sudo gem install als_typograf --source=http://gemcutter.org/</code></pre>
</li>
	<li>В коде приложения используйте метод <code class="ruby">process</code> модуля <code class="ruby">AlsTypograf</code> следующим образом:
<pre><code class="ruby">require 'als_typograf'
AlsTypograf.process('- Это что, "Типограф"?') # "&lt;p&gt;— Это что, «Типограф»?&lt;/p&gt;"</code></pre>
</li>
</ol>
Обёртка поддерживает несколько опций, предоставляемых веб-сервисом Студии, их можно подставлять как к конкретному запросу:
<pre><code class="ruby">AlsTypograf.process('- Это что, "Типограф"?', :use_p =&gt; false, :use_br =&gt; true)</code></pre>
так и выставлять глобально, для всех запросов на типографирование:
<pre><code class="ruby">AlsTypograf.encoding = 'CP1251' # По-умолчанию используется кодировка UTF-8
AlsTypograf.html_entities! # Заставляет использовать сущности HTML, такие как: &amp;nbsp;, &amp;mdash; &amp;hellip;</code></pre>
<a href="http://rdoc.info/projects/rotuka/als_typograf">Документация для рубинового типографа</a> хранится (и автоматически обновляется при любых изменениях) на сервисе <a href="http://rdoc.info/">rdoc.info</a>, который весьма рекомендую всем разработчикам.
