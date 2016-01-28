---
date: 2008-10-01 03:03
title: Настройка тачпада в Ubuntu
slug: configuring-touchpad-in-ubuntu
type: post
tags: Synaptics, touchpad, Ubuntu
published: false
---

Недавно я стал обладателем нетбука Acer Aspire One, и я, в связи с этим, открываю рубрику Ubuntu на нетбуке (да, сказано громко, но ещё будет как минимум одна статья в этой рубрике :-) ). В первую очередь стоит вспомнить Ubuntu Netbook Remix — специальную сборку убунту для нетбуков. Она решает множество проблем, но недостатки всё же остаются.
<h2>Игнорирование случайных нажатий</h2>
Первая проблема в использовании нетбука — непривычный размер клавиатуры. И, поскольку, тачпад находится очень близко к ней — часто происходят случайные нажатия, это сильно мешает. Но решение есть, и оно устанавлено по-умолчанию. Его нужно просто активировать. Это — демон <code>syndaemon</code>. Он отслеживает события клавиатуры и отключает тачпад, когда вы начинаете печатать. Есть несколько опций:

<div class="container">
<dl class="b-options-list">
  <dt><code>-d</code></dt>
  <dd>запускает процесс в виде демона, что позволяет запустив его закрыть терминал и т. п.</dd>
  <dt><code>-k</code></dt>
  <dd>игнорирование нажатий клавиш-модификаторов, таких как <kbd>Ctrl</kbd>, <kbd>Alt</kbd> и т. п. Если вы кодга-либо собираетесь использовать <kbd>Ctrl</kbd>+клик мышкой — включите эту опцию</dd>
  <dt><code>-t</code></dt>
  <dd>заставляет <code>syndaemon</code> отключать только скроллинг и нажатия, оставляя возможность перемещения мыши во время печати на клавиатуре (интересно, зачем это‽)</dd>
  <dt><code>-i <em>1</em></code></dt>
  <dd>обычно <code>syndaemon</code> отключает тачпад на две секунды после любого события клавиатуры. Чтобы изменить это время, укажите количество секунд после <code>-i</code></dd>
</dl>
</div>

Выбрав необходимые параметры, добавьте получившийся вызов демона (напр. <code>syndaemon -d -k -i 1</code> ) <a href="https://help.ubuntu.com/community/AddingProgramToSessionStartup">в атозапуск</a>.

<h2>Настройка тачпада</h2>
<h2>Использованные материалы:</h2>
<ul>
	<li><a href="https://help.ubuntu.com/community/SynapticsTouchpad">Synaptics touchpad — </a><a href="https://help.ubuntu.com/community/SynapticsTouchpad">Ubuntu community help</a></li>
	<li><a href="http://linux.die.net/man/5/synaptics">synaptics Man page</a></li>
	<li><a href="http://habrahabr.ru/blogs/linux/53863/">Круговая прокрутка а-ля iPod на тачпаде</a></li>
</ul>
