---
date: 2009-11-25 08:08
title: Ставим рубиновый типограф на Рельсы
slug: artlebedev-typograf-ruby-on-rails
type: post
tags: Ruby, Ruby on Rails, Студия Артемия Лебедева, типографика
---

В продолжение <a href=\"http://al.semyonov.us/artlebedev-typograf-ruby/\">вчерашней темы</a>, добавил простой способ типографить избранные поля в модели ActiveRecord.

Достаточно написать в нужной модели примерно следующее:
<pre><code class=\"ruby\">class Article &lt; ActiveRecord::Base
  typograf :title, :use_p =&gt; false, :use_br =&gt; false
  typograf :content, :teaser
end
</code></pre>
И тогда каждый раз перед сохранением (конкретнее, перед проверкой правильности полей) будет проходить типографирование этих полей, посредством Типографа студии Артемия Лебедева.

Поддерживается <a href=\"http://rdoc.info/projects/rotuka/als_typograf\">несколько возможных синтаксисов</a> объявления моделей для типографирования:
<ul>
	<li>для одного конкретного поля:
<pre><code class=\"ruby\">typograf :content</code></pre>
</li>
	<li>можно указать параметры для типографирования этого поля:
<pre><code class=\"ruby\">typograf :content, :entity_type =&gt; AlsTypograf::NO_ENTITIES</code></pre>
</li>
	<li>для нескольких полей сразу (тоже с возможностью объявить параметры типографирования, общие для всех объявленных полей):
<pre><code class=\"ruby\">typograf :skills, :achievements, :additional, :use_br =&gt; false, :use_p =&gt; true</code></pre>
</li>
	<li>для нескольких полей сразу (но с объявлением параметров для каждого конкретного поля):
<pre><code class=\"ruby\">typograf :foo =&gt; {:entity_type =&gt; AlsTypograf::HTML_ENTITIES},
         :bar =&gt; {:use_p =&gt; true, :use_br =&gt; false},
         :baz =&gt; {:max_nobr =&gt; 5},
         :some_other_field_name =&gt; {}</code></pre>
</li>
</ul>
Все эти варианты могут комбинироваться друг с другом внутри одной модели произвольное количество раз (но если параметры типографирования для одного и того же поля были указаны в вызовах несколько раз, будут применяться только последние).
