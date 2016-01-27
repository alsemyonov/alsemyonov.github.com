---
date: 2008-10-19 11:11
title: Разработка сайтов в Ubuntu или LAMP = Ubuntu + Apache + MySQL + PHP
slug: lamp-ubuntu-apache-mysql-php
type: post
tags: Apache, MySQL, PHP, Ubuntu
---

Ubuntu - это линукс для людей. Поэтому, установка набора для веб-разработчика в нём производится одной командой:
<pre><code class="bash">sudo tasksel install lamp-server</code></pre>
После её выполнения, на вашем компьютере обоснуются Apache, MySQL и PHP. А мы сразу же займёмся созданием первого сайта.

Все сайты, над которыми тружусь, я храню в папках вида <code>~/Sites/www.example.com.dev/</code>. Это удобно, потому как не приходится настраивать права доступа к файлам и придумывать структуру папок в <code>/var/www/</code>, а так же каждому из них можно выделить человекочитаемое имя, оканчивающееся на .dev (которое соответствует названию папки), и при разработке и тестировании набирать в адресной строке браузера www.rotuka.com.dev и попадать на локальную версию вашего сайта.
<h2>Создание и настройка текстового сайта</h2>
Допустим, мы приступаем к разработке сайта <a title="Блог разработчика веба" href="http://rotuka.com/">rotuka.com</a>, тогда создадим для него личную папку
<pre><code class="bash">mkdir -p ~/Sites/rotuka.com.dev/public</code></pre>
Теперь, нам нужно рассказать нашему локальному апачу об этом сайте. Создаём файлик для этого сайта:
<pre><code class="bash">sudo gedit /etc/apache2/sites-available/rotuka.com.dev</code></pre>
и вписываем в него следующие строки:
<pre><code>&lt;VirtualHost *:80&gt;
    ServerName rotuka.com.dev
    ServerAlias www.rotuka.com.dev
    DocumentRoot /home/$USER/Sites/rotuka.com.dev/public
&lt;/VirtualHost&gt;</code></pre>
где <code>$USER</code> нужно заменить на ваше имя пользователя.

Сохраняем файл, закрываем gedit и говорим апачу, что этот сайт теперь нужно обслуживать:
<pre><code class="bash">sudo a2ensite rotuka.com.dev</code></pre>
При выполнении, эта команда скажет вам, что апачу необходимо перезагрузить данные конфигурации, что мы и сделаем:
<pre><code class="bash">sudo /etc/init.d/apache2 reload</code></pre>
Теперь, настроим удобное обращение к сайту. Для этого пропишем, что хост rotuka.com.dev обслуживается на нашем компьютере, локально. Открываем файл <code>/etc/hosts</code>
<pre><code class="bash">sudo gedit /etc/hosts</code></pre>
находим там строку, начинающуюся на 127.0.0.1 (обычно, это первая строка) и вписываем в её конец, через пробел от предыдущих данных, <code>rotuka.com.dev</code>. Сохраняем файл, закрываем редактор.

Теперь кидаем какой-нибудь файлик index.html в папочку нашего сайта (<code>/home/$USER/Sites/www.rotuka.com.dev/public</code>) или выполняем команду
<pre><code class="bash">echo -e "&lt;html&gt;\n  &lt;head&gt;\n    &lt;meta http-equiv="Content-type" content="text/html;
charset=utf-8" /&gt;\n    &lt;title&gt;Тестовый сайт&lt;/title&gt;\n  &lt;/head&gt;\n  &lt;body&gt;\n
&lt;h1&gt;Тестовый сайт&lt;/h1&gt;\n    &lt;p&gt;Привет, веб-разработчик&lt;/p&gt;\n  &lt;/body&gt;\n&lt;/html&gt;\n"
&gt; /home/$USER/Sites/rotuka.com.dev/index.html</code></pre>
Всё, теперь уже можно вписать в адресную строку браузера http://rotuka.com.dev/ и увидеть, что сайт вас приветствует (-:

<h2>Ссылки по-теме:</h2>
<ul>
	<li><a href="http://www.tux.in.ua/articles/1169">Пошаговое руководство по установке LAMP сервера в Ubuntu</a> — очень подробно, с нюансами конфигурации</li>
</ul>
