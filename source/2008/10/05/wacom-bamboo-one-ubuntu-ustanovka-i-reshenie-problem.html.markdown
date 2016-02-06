---
date: 2008-10-05 22:10
title: Wacom Bamboo One + Ubuntu. Установка и решение проблем
slug: wacom-bamboo-one-ubuntu-ustanovka-i-reshenie-problem
type: post
tags: Ubuntu, Wacom Bamboo One
category: Ubuntu
---

Вчера мне в руки попал планшетик <a title="Wacom Bamboo One" href="http://www.wacom.ru/bamboo_one.html">Wacom Bamboo One</a>. Забавная вещица. Если её установить (-;

<a title="Wacom in Ubuntu" href="https://help.ubuntu.com/community/Wacom">Страница руководства</a>, посвящённая Wacom посылает нас на довольно <a href="http://ubuntuforums.org/showthread.php?t=765915">подробное руководство по установке и настройке</a> последних драйверов для линейки Bamboo, которое приведёт вас к вполне рабочему тандему Бамбук+Убунту, однако если вы используете терминал, либо постраничный поиск в файрфоксе, либо вы просто любите системный звук ошибки - вы получите много проблем. Ибо теперь каждый вызов системного сигнала будет приводить к перезагрузке <a href="http://x.org/">иксов</a>.

Решения этой проблемы гугл не знает. Яндекс, кстати, тоже. И лишь кустарные методы позволят использовать. Чтобы лишить себя проблем (хотя бы временно), выполните следующие действия:
<ol>
	<li>Откройте настройку звука (<strong>Система</strong> -&gt; <strong>Параметры</strong> -&gt; <strong>Звук</strong>) и на вкладе "<strong>Системный сигнал</strong>" снимите галочку с параметра "<strong>Включить системный сигнал</strong>" и поставьте галочку "<strong>Визуальный системный сигнал</strong>", чтобы вместо звука сигнал был произведён путём мигания какой-либо области экрана.</li>
	<li>Запустите терминал (<strong>Приложения</strong> -&gt; <strong>Стандартные</strong> -&gt; <strong>Терминал</strong>), выберите в меню <strong>Правка</strong> -&gt; <strong>Текущий профиль...</strong> и снимите галочку с параметра "<strong>Подавать гудок</strong>"</li>
	<li>Запустите Firefox (<strong>Приложения</strong> -&gt; <strong>Интернет</strong> -&gt; <strong>Firefox Web Browser</strong>) и введите в адресной строке <strong>about:config</strong>. Затем найдите параметр <strong>accessibility.typeaheadfind.enablesound</strong> и поставьте ему значение <strong>false</strong>.</li>
</ol>
