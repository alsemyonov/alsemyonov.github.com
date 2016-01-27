---
date: 2009-09-15 20:08
title: Интеграция WYSiWYG-редактора TinyMCE в рельсовые приложения
slug: tinymce-integration-ruby-on-rails
type: post
tags: Ruby, RubyGems, Ruby on Rails, TinyMCE, WYSIWYG
---

Вчера закончил работу (ну, её было не очень много) по переделыванию <a title="Плагин TinyMCE для Ruby on Rails" href="http://github.com/kete/tiny_mce">плагина TinyMCE для рельсов</a> в <a title="гем tiny_mce на GemCutter" href="http://gemcutter.org/gems/tiny_mce">полноценный gem</a>. <span style="background-color: #ffffff;">Теперь редактировать текстовые данные в рельсовых приложениях ещё проще.</span>

Достаточно вставить в <code>environment.rb</code>:
<pre><code class="ruby">config.gem 'tiny_mce', :source =&gt; 'http://gemcutter.org/'</code></pre>
В нужный <em>контроллер</em>:
<pre><code class="ruby">uses_tiny_mce :only =&gt; [:new, :create, :edit, :update]</code></pre>
В <em>обёртку</em>:
<pre><code class="ruby">= include_tiny_mce_if_needed</code></pre>
А в <em>представлении</em> указать у нужного поля текста класс <code>mceEditor</code>:
<pre><code class="ruby">- form_for @page do |f|
  = f.text_area :content, :class =&gt; 'mceEditor'</code></pre>
После этого остановите свой проект, наберите в командной строке <code>rake gems:install</code>, запустите проект снова — файлы для TinyMCE автоматически установятся в нужное место. Если вы обновите гем (например, в связи с обновлением кода TinyMCE его авторами) — удалите <code>public/javascript/tiny_mce</code>, перезапустите приложение и новые файлы лягут в нужное место.

Всё, теперь пользователи вашего сайта смогут вытворять всякие ужасы с текстом, а так же рвать вашу вёрстку и делать прочие непотребности. <em>Наслаждайтесь!</em>

<h2>Ссылки проекта:</h2>
<ul>
	<li><span style="background-color: #ffffff;"><a title="tiny_mce на ГитХабе" href="http://github.com/krasivotokak/tiny_mce">Код</a></span></li>
	<li><span style="background-color: #ffffff;"><a title="tiny_mce на RDoc" href="http://rdoc.info/projects/krasivotokak/tiny_mce/">Документация</a></span></li>
</ul>
