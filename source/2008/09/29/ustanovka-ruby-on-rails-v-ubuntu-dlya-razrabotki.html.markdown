---
date: 2008-09-29 05:05
title: Установка Ruby on Rails в Ubuntu (для разработки)
slug: ustanovka-ruby-on-rails-v-ubuntu-dlya-razrabotki
type: post
tags: Ruby, RubyGems, Ruby on Rails
category: Backend Development
---

Я постараюсь поддерживать эту статью в актуальном состоянии. На данный момент, все действия, описанные в статье, актуальны для следующих версий ПО:
<ul>
	<li>Ubuntu Karmic Koala (9.10)</li>
	<li>Ruby 1.8.7 (2009-06-12 patchlevel 174)</li>
	<li>Rubygems 1.3.5</li>
	<li>Ruby on Rails 2.3.4</li>
</ul>
<h2>Установка Ruby</h2>
В репозиториях Убунту лежит актуальная версия интерпретатора Ruby, поэтому для установки Ruby хватит одной стандартной команды:
<pre><code class="bash">sudo apt-get install ruby-full build-essential libruby-extras libsqlite3-ruby</code></pre>
<h2>Установка Rubygems</h2>
<ol>
<li>RubyGems в репозитории Ubuntu Karmic пока актуальные, поэтому можно смело ставить из репозитория командой:
<pre><code class="bash">sudo apt-get install rubygems</code></pre></li>
<li>Однако, если вы предпочитаете ручную установку RubyGems, воспользуйтесь следующими командами:
<pre><code class="bash">wget http://rubyforge.org/frs/download.php/60718/rubygems-1.3.5.tgz
tar xzvf rubygems-1.3.5.tgz
cd rubygems-1.3.5
sudo ruby setup.rb
sudo ln -s /usr/bin/gem1.8 /usr/bin/gem</code></pre>
Для того, чтобы у вас заработало дополнение команд в консоли, необходимо открыть файл настроек дополнения
<pre><code class="bash">sudo gedit /etc/bash_completion.d/gem1.8</code></pre>
И вставить в начало этого файла, сразу после комментариев, следующий код:
<pre><code class="bash">have()
{
  unset -v have
  PATH=$PATH:/sbin:/usr/sbin:/usr/local/sbin type $1 &amp;&gt;/dev/null &amp;&amp;
  have="yes"
}</code></pre>
А в самый конец вставить:
<pre><code class="bash">[ -n "${have:-}" ] &amp;&amp; complete -F _gem18 $filenames gem</code></pre>
Теперь вы в консоли сможете набирать <code>gem i</code> и консоль будет сама дополнять команду до <code>gem install</code>,

Если же у вас уже была установлена более старая версия Rubygems, вы можете обновить её до текущей:
<pre><code class="bash">sudo gem update --system</code></pre>
Иногда, после обновления этой командой, gem может начать выдавать ошибку:
<pre><code class="bash">/usr/bin/gem:23: uninitialized constant Gem::GemRunner (NameError)</code></pre>
Для её устранения, необходимо отредактировать исполняемый файл (<code class="bash">sudo gedit /usr/bin/gem</code>) и перед строкой <code lang="ruby">require "rubygems"</code> вставить строку <code lang="ruby">require "rubygems/gem_runner"</code>
</li></ol>
<h2>Установка Rails</h2>
Теперь, когда нас установлены актуальные версии интерпретатора и менеджера гемов, мы можем присутпить к установке самих Rails.
<pre><code class="bash">sudo gem install rails</code></pre>
Всё, рельсы установлены. Чтобы проверить, что всё в порядке, создадим приложение на рельсах:
<pre><code class="bash">cd ~
mkdir Sites
cd Sites
rails my_first_site
cd my_first_site
./script/server</code></pre>
Эти команды создадут в вашей домашней директории поддиректории Sites, а в ней, в директории my_first_site rails-приложение, после чего запустит стандартный сервер WEBrick, поставляемый вместе с интерпретатором Ruby. Если установка прошла без ошибок, то вы сможете увидеть приветствие рельсов, пройдя по ссылке <a href="http://127.0.0.1:3000/">http://127.0.0.1:3000/</a>.
<h2>Установка дополнительных гемов</h2>
В дальнейшем, при работе с рельсами, вам может понадобиться множество различных гемов. Описывать установку всех я не буду. Опишу лишь то, с чем у меня когда-либо случались проблемы. Начнём, пожалуй, с гема <strong>rmagick</strong>, предназначенного для обработки изображений.

Если для вас не обязательно наличие самой последней версии этого гема, вы можете ограничиться командой
<pre><code class="bash">sudo apt-get install librmagick-ruby</code></pre>
Если же вы захотите установить самую последнюю версию этого гема, вам нужно будет скачать исходные коды для библиотек ImageMagick (а они потянут за собой много-много других библиотек). Скорее всего, для вас это излишне. Но команды напишу:
<pre><code class="bash">sudo apt-get install libmagick9-dev
sudo gem install rmagick</code></pre>
Ещё лично я советую поставить вам несколько плагинов, которые облегчат вам жизнь при работе с Rails вдальнейшем. Установка одной командой:
<pre><code class="bash">sudo gem install mongrel BlueCloth RedCloth sqlite3-ruby ZenTest</code></pre>
И о каждом геме поподробнее:
<ul>
	<li><strong>mongrel</strong> — более быстрый, чем WEBrick сервер, написанный специально для работы с Rails. Если н установлен, то по команде ./script/server рельсы станут запускать именно его.</li>
	<li><strong>BlueCloth</strong> и <strong>RedCloth</strong> — библиотеки, используемые рельсовыми хелперами <code>markdown</code> и <code>textilize</code> соответственно для разметки текста.</li>
	<li><strong>sqlite3-ruby</strong> — библиотека для работы с базами sqlite3 (которые создаются по-умолчанию при создании рельсового приложения).</li>
	<li><strong>ZenTest</strong> — набор утилит для автоматического тестирования приложения. По команде <code>autotest</code> запускается тестирующий демон, который будет проверять все изменённые файлы, пробегая связанные с ними тесты. Об этой утилите я напишу позже</li>
</ul>


*[ПО]: Программное обеспечени
