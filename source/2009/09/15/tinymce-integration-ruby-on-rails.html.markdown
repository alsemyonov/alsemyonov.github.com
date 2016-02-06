---
date: 2009-09-15 20:08
title: Интеграция WYSiWYG-редактора TinyMCE в рельсовые приложения
slug: tinymce-integration-ruby-on-rails
type: post
tags: Ruby, RubyGems, Ruby on Rails, TinyMCE, WYSIWYG
category: Backend Development
---

Вчера закончил работу (ну, её было не очень много) по переделыванию [плагина TinyMCE для рельсов](http://github.com/kete/tiny_mce "Плагин TinyMCE для Ruby on Rails") в [полноценный gem](http://gemcutter.org/gems/tiny_mce "гем tiny_mce на GemCutter"). <span style="background-color: #ffffff;">Теперь редактировать текстовые данные в рельсовых приложениях ещё проще.</span>

Достаточно вставить в `environment.rb`:

``` ruby
config.gem 'tiny_mce', source: 'http://gemcutter.org/'
```

В нужный *контроллер*:

``` ruby
uses_tiny_mce only: [:new, :create, :edit, :update]
```

В *обёртку*:

``` ruby
include_tiny_mce_if_needed
```

А в *представлении* указать у нужного поля текста класс `mceEditor`:

``` ruby
 form_for @page do |f|
  f.text_area :content, class: 'mceEditor'
 end
```

После этого остановите свой проект, наберите в командной строке `rake gems:install`, запустите проект снова — файлы для TinyMCE автоматически установятся в нужное место. Если вы обновите гем (например, в связи с обновлением кода TinyMCE его авторами) — удалите `public/javascript/tiny_mce`, перезапустите приложение и новые файлы лягут в нужное место.

Всё, теперь пользователи вашего сайта смогут вытворять всякие ужасы с текстом, а так же рвать вашу вёрстку и делать прочие непотребности. *Наслаждайтесь!*

## Ссылки проекта:

* [Код](http://github.com/krasivotokak/tiny_mce "tiny_mce на ГитХабе")
* [Документация](http://rdoc.info/projects/krasivotokak/tiny_mce/ "tiny_mce на RDoc")
