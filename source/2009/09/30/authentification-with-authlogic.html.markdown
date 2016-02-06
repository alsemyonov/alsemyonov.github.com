---
date: 2009-09-30 14:02
title: Аутентификация пользователей с Authlogic
slug: authentification-with-authlogic
type: post
tags: Authlogic, Ruby on Rails, аутентификация
published: false
category: Backend Development
---

Решил описать простой способ аутентификации с помощью прекрасного gem'а от BinaryLogic — Authlogic.

Эта библиотека позволяет не засорять контроллер аутентификации и модель пользователя, вынося всю «грязную» работу в свои модули. Она, также, поддерживает множество методов аутентификации (логин+пароль, электронная почта+пароль, одноразовая ссылка, многоразовая ссылка), а так же расширяется плагинами (<a title="Authlogic LDAP" href="http://github.com/binarylogic/authlogic_ldap ">LDAP</a>, <a title="Authlogic OpenID" href="http://github.com/binarylogic/authlogic_openid ">OpenID</a>, <a title="Authlogic OAuth" href="http://github.com/jrallison/authlogic_oauth">OAuth</a>, <a title="Authlogic Facebook Connect" href="http://github.com/kalasjocke/authlogic_facebook_connect">Facebook Connect</a>). Рассмотрим простейший случай аутентификации — электронная почта и пароль.
<ol>
	<li>Генерируем модель <code>User</code>:
<pre><code class="bash">./script/generate resource User email:string crypted_password:string
password_salt:string persistence_token:string</code></pre>
</li>
	<li>Настраиваем поддержку <code>authlogic</code>
<pre><code class="ruby">class User &lt; ActiveRecord::Base
  acts_as_authentic
end</code></pre>
</li>
	<li>Генерируем <strong>модель сессии</strong> и контроллер входа-выхода
<pre><code class="bash">./script/generate session UserSession
./script/generate controller UserSessions new</code></pre>
</li>
</ol>
