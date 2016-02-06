---
date: 2008-09-16 03:03
title: Настройка GTalk в Kopete (KDE4)
slug: setup-gmail-in-kopete-kde4
type: post
tags: GTalk, KDE 4, Kopete, Ubuntu
category: Ubuntu
---

Сегодня поставил на&nbsp;своём лаптопе <strong>Kubuntu KDE4</strong> и&nbsp;столкнулся с&nbsp;проблемой при настройке GTalk в&nbsp;Kopete. При соединении выдавалась ошибка &laquo;SSL support could not be&nbsp;initialized for account user@example.com. This is&nbsp;most likely because the QCA TLS plugin os&nbsp;not installed on&nbsp;your system&raquo;.

Первым делом я,&nbsp;естественно, попытался решить эту проблему путём установки этого самого <strong>QCA TLS</strong>, довольно логично, не&nbsp;правда&nbsp;ли? Тем более, что и&nbsp;пакетик в&nbsp;репозиториях нашёлся одноименный.

<code>sudo apt-get install qca-tls</code>

После этого перезапускаю Kopete и... вылетает та&nbsp;же самая ошибка. Перечитываю сообщение об&nbsp;ошибке, вижу замечание о&nbsp;<em>плагине</em> и&nbsp;после непродолжительного поиска по&nbsp;пакетам, выполняю

<code>sudo apt-get install libqca2-plugin-ossl</code>

После этого перезапускаю Kopete и... вуаля, всё заработало.

Кстати, не лишним будет напомнить, что для общения с&nbsp;вашего аккаунта GTalk из&nbsp;Копете необходимо выставить следующие настройки:
<ol>
<li>При создании аккаунта выбрать протокол <strong>Jabber</strong></li>
<li>В качестве Jabber ID&nbsp;ввести ваше имя пользователя, вместе с&nbsp;доменным именем, то&nbsp;есть username@gmail.com или username@example.com если вы&nbsp;используете Google Apps на&nbsp;домене вашей организации и&nbsp;т.&nbsp;п.</li>
<li>В параметрах соединения (Вкладка Connection) поставить все три галочки: Use protocol encryption (SSL); Allow plain-text password authentication; Override default server information</li>
<li>Выставить в&nbsp;качестве имени сервера <strong>talk.google.com</strong>, порт <strong>5223</strong>.</li>
</ol>
Этих настроек должно быть вполне достаточно для комфортной работы. Не&nbsp;забудьте установить поддержку QCA TLS, если выскочит ошибка. Одной командой это делается так:

<code>sudo apt-get install qca-tls libqca2-plugin-ossl</code>
