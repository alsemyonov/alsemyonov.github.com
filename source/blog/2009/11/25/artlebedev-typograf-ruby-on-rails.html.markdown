---
date: 2009-11-25 08:08
title: Ставим рубиновый типограф на Рельсы
slug: artlebedev-typograf-ruby-on-rails
type: post
tags: Ruby, Ruby on Rails, Студия Артемия Лебедева, типографика
---

В продолжение [вчерашней темы](../../24/artlebedev-typograf-ruby), добавил простой способ типографить избранные поля в модели ActiveRecord.

Достаточно написать в нужной модели примерно следующее:

``` ruby
class Article < ActiveRecord::Base
  typograf :title, use_p: false, use_br: false
  typograf :content, :teaser
end
```

И тогда каждый раз перед сохранением (конкретнее, перед проверкой правильности полей) будет проходить типографирование этих полей, посредством Типографа студии Артемия Лебедева.

Поддерживается [несколько возможных синтаксисов](http://www.rubydoc.info/gems/als_typograf) объявления моделей для типографирования:

*   для одного конкретного поля:

    ``` ruby
    typograf :content
    ```
*   можно указать параметры для типографирования этого поля:

    ``` ruby
    typograf :content, entity_type: AlsTypograf::NO_ENTITIES
    ```

*   для нескольких полей сразу (тоже с возможностью объявить параметры типографирования, общие для всех объявленных полей):

    ``` ruby
    typograf :skills, :achievements, :additional,
             use_br: false,
             use_p: true
    ```

*   для нескольких полей сразу (но с объявлением параметров для каждого конкретного поля):

    ``` ruby
    typograf foo: {entity_type: AlsTypograf::HTML_ENTITIES},
             bar: {use_p: true, use_br: false},
             baz: {max_nobr: 5},
             some_other_field_name: {}
    ```

Все эти варианты могут комбинироваться друг с другом внутри одной модели произвольное количество раз (но если параметры типографирования для одного и того же поля были указаны в вызовах несколько раз, будут применяться только последние).
