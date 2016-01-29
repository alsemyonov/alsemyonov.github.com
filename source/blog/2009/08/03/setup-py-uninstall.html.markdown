---
date: 2009-08-03 21:09
title: Удаление программ с помощью setup.py
slug: setup-py-uninstall
type: post
tags: build, checkinstall, install, Python, setup.py, uninstall, памятка, Памятки
---

Некоторые программы написанные на Питоне (например, <a href="https://fedorahosted.org/lekhonee/">Lekhonee</a>) поставляются с файликом <a title="The Setup Script" href="http://docs.python.org/distutils/setupscript.html">setup.py</a>, с помощью которого довольно просто устанавливаются
<pre><code class="bash">python setup.py build
sudo python setup.py install</code></pre>
А вот удалить такую программу достаточно сложно, ибо команды <code class="bash">sudo python setup.py uninstall</code> нету. Ну, не предусмотрели его любители красивого кода на питоне. Красивое, ведь, лучше, чем некрасивое, ага? А код на Питоне, видимо, настолько красивый, что удалять его со своего компьютера — грех смертный.

Тем не менее, способ удаления таких программ есть, и он довольно прост:
<pre><code class="bash">sudo python setup.py install --record files.txt
cat files.txt | sudo xargs rm -rf
</code></pre>
На самом деле, неприятно удивляет это питоновское стандартное средство установки программ. Но, оказывается, бывает и такое.
<h2>А если подумать перед установкой…</h2>
…то можно использовать уже упоминавшийся в блоге checkinstall:
<pre><code class="bash">sudo checkinstall python setup.py install</code></pre>
Тогда деинсталлировать это приложение можно будет как обычно, с помощью apt:
<pre><code class="bash">sudo apt-get purge lekhonee</code></pre>
