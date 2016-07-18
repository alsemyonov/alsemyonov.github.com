---
date: 2009-09-30 13:01
title: Метапрограммирование в Ruby
slug: ruby-metaprogramming
type: post
tags: Ruby, Метапрограммирование, Переводы, программирование
category: Backend Development
---

## Что такое метапрограммирование?

> Metaprogramming is the writing of computer programs that write or manipulate other programs (or themselves) as their data, or that do part of the work at compile time that would otherwise be done at runtime. In many cases, this allows programmers to get more done in the same amount of time as they would take to write all the code manually, or it gives programs greater flexibility to efficiently handle new situations without recompilation. (via Wikipedia)

Это руководство перечисляет все стандартные методы Ruby, используемые для метапрограммирования, а так же приводит примеры их обычного употребления. В конце мы получим пример использования метапрограммирования для динамического создания классов, соответствующих таблицам в БД, включающих методы, соответствующие полям таблицы, на манер `ActiveRecord`.

## Инструментарий метапрограммиста

Ruby содержит множество методов для динамического создания кода. Ознакомимся с ними:

### Получение, установка и удаление переменных

* [`Object#instance_variable_get`](http://www.rubydoc.info/stdlib/core/Object#instance_variable_get-instance_method)
* [`Object#instance_variable_set`](http://www.rubydoc.info/stdlib/core/Object#instance_variable_set-instance_method)
* [`Object#remove_instance_variable`](http://www.rubydoc.info/stdlib/core/Object#remove_instance_variable-instance_method)
* [`Module#class_variable_get`](http://www.rubydoc.info/stdlib/core/Module#class_variable_get-instance_method)
* [`Module#class_variable_set`](http://www.rubydoc.info/stdlib/core/Module#class_variable_set-instance_method)
* [`Module#remove_class_variable`](http://www.rubydoc.info/stdlib/core/Module#remove_class_variable-instance_method)

### Получение, установка и удаление констант (и классов)

* [`Module#const_get`](http://www.rubydoc.info/stdlib/core/Module#const_get-instance_method)
* [`Module#const_set`](http://www.rubydoc.info/stdlib/core/Module#const_set-instance_method)
* [`Module#remove_const`](http://www.rubydoc.info/stdlib/core/Module#remove_const-instance_method)

### Объявление и удаление методов

* [`Module#define_method`](http://www.rubydoc.info/stdlib/core/Module#define_method-instance_method)
* [`Module#remove_method`](http://www.rubydoc.info/stdlib/core/Module#remove_method-instance_method)

### Выполнение кода, построенного «на лету»

* [`Object#send`](http://www.rubydoc.info/stdlib/core/Object#send-instance_method)
* [`Object#instance_eval`](http://www.rubydoc.info/stdlib/core/Object#instance_eval-instance_method)
* [`Module#module_eval`](http://www.rubydoc.info/stdlib/core/Module#module_eval-instance_method) (синоним [`Module#class_eval`](http://www.rubydoc.info/stdlib/core/Module#class_eval-instance_method))
* [`Kernel#eval`](http://www.rubydoc.info/stdlib/core/Kernel#eval-instance_method)
* [`Kernel#method_missing`](http://www.rubydoc.info/stdlib/core/Kernel#method_missing-instance_method)

### Методы интроспекции (рефлексии, отражения)

Интроспекция — важная часть метапрограммирования, позволяющая изучать объекты, получая их структуру и данные

* [`Object#class`](http://www.rubydoc.info/stdlib/core/Object#class-instance_method)
* [`Object#instance_variables`](http://www.rubydoc.info/stdlib/core/Object#instance_variables-instance_method)
* [`Object#methods`](http://www.rubydoc.info/stdlib/core/Object#methods-instance_method)
* [`Object#private_methods`](http://www.rubydoc.info/stdlib/core/Object#private_methods-instance_method)
* [`Object#public_methods`](http://www.rubydoc.info/stdlib/core/Object#public_methods-instance_method)
* [`Object#singleton_methods`](http://www.rubydoc.info/stdlib/core/Object#singleton_methods-instance_method)
* [`Module#class_variables`](http://www.rubydoc.info/stdlib/core/Module#class_variables-instance_method)
* [`Module#constants`](http://www.rubydoc.info/stdlib/core/Module#constants-instance_method)
* [`Module#included_modules`](http://www.rubydoc.info/stdlib/core/Module#included_modules-instance_method)
* [`Module#instance_methods`](http://www.rubydoc.info/stdlib/core/Module#instance_methods-instance_method)
* [`Module#name`](http://www.rubydoc.info/stdlib/core/Module#name-instance_method)
* [`Module#private_instance_methods`](http://www.rubydoc.info/stdlib/core/Module#private_instance_methods-instance_method)
* [`Module#protected_instance_methods`](http://www.rubydoc.info/stdlib/core/Module#protected_instance_methods-instance_method)
* [`Module#public_instance_methods`](http://www.rubydoc.info/stdlib/core/Module#public_instance_methods-instance_method)

## Выполнение кода в строках и блоках

Вы могли слышать о методе eval, позволяющем выполнять строку или блок как код на Ruby. Когда нужно выполнить код внутри контекста какого-то объекта, можно использовать методы `instance_eval` и `module_eval` (синоним `class_eval`).

Метод `instance_eval` выполняет код в контексте существующего объекта.

``` ruby
[1, 2, 3, 4].instance_eval('size') # вернёт 4
```

В примере мы передали методу `instance_eval` строку `'size'`, что интерпретировалось как получение метода `:size` массивом. Это эквивалентно следующему вызову:

``` ruby
[1, 2, 3, 4].size
```

Кроме того, вы можете передавать методу `instance_eval` блок.

``` ruby
# Получаем среднее арифметическое чисел в массиве
[1, 2, 3, 4].instance_eval { inject(:+) / size.to_f } # вернёт 2.5
```

Методы `inject(:+)` и `size.to_f` вроде бы «висят в воздухе» и не относятся ни к какому объекту, однако они выполняются в блоке, в контексте объекта, поэтому они интерпретируются как `self.inject(:+)` и `self.size.to_f` где `self` — наш массив.

В то время как `instance_eval` выполняет код в контексте объекта, метод `module_eval` выполняет код в контексте модуля или класса.

``` ruby
Fixnum.module_eval do
  def to_word
    if (0..3).include? self
      ['ничего', 'один', 'пара', 'несколько'][self]
    elsif self > 3
      'много'
    elsif self < 0
      'отрицательно'
    end
  end
end
1.to_word # вернёт 'один'
2.to_word # вернёт 'пара'
```

Мы видим, как `module_eval` заново открывает существующий класс `Fixnum` и добавляет в него новый метод. Само по себе это не очень интересно, и мы можем сделать это иначе:

``` ruby
class Fixnum
  def to_word
    # ...
  end
end
```

Лучшее применение этому методу мы найдём при динамическом генерировании кода. Добавим метод `create_multiplier`, который позволит динамически генерировать методы-умножители с теми именами, которые вы захотите.

``` ruby
class Fixnum
  def self.create_multiplier(name, num)
    module_eval "def #{name}; self * #{num}; end"
  end
end

Fixnum.create_multiplier('multiply_by_pi', Math::PI)
4.multiply_by_pi # вернёт 12.5663706143592 
```

Пример выше создаёт метод класса (или  «метод-синглетон») `create_multiplier`, с помощью которого мы сможем создавать методы, применимые к любому объекту класса `Fixnum`.

## Использование `send`

Метод `send` работает почти как `instance_eval`, поскольку вызывает метод объекта, переданный в качестве параметра. Он удобен, когда мы динамически получаем имя необходимого метода в виде строки или символа.

``` ruby
method_name = 'size'
[1, 2, 3, 4].send(method_name) # вернёт 4
```

Мы можем передать имя метода в виде строки `'size'` или символа `:size`

Полезное свойство метода `send` — возможность вызывать приватные методы, как например метод [`Module#define_method`](http://www.rubydoc.info/stdlib/core/Module#define_method-instance_method).

``` ruby
Array.define_method(:ducky) { puts 'ducky' }
# NoMethodError: private method `define_method' called for Array:Class
```

Используя `send` получаем:

``` ruby
Array.send(:define_method, :ducky) { puts 'ducky' }
```

## Создание методов

Как мы видим в примере выше, мы можем создавать методы классов с помощью `define_method`.

``` ruby
class Array
  define_method(:multiply) do |arg|
    collect { |i| i * arg }
  end
end

[1, 2, 3, 4].multiply(16) # returns [16, 32, 48, 64]
```

<h2>method_missing</h2>
Метод `method_missing`, объявленный в классе, вызывается в случае получения экземпляром класса несуществующего метода. Это может быть использовано для выполнения этих отсутвующих методов, вместо отправки ошибки `NoMethodError`.

``` ruby
class Fixnum
  def method_missing(meth)
    method_name = meth.id2name
    if method_name =~ /^multiply_by_(\d+)$/
      self * $1.to_i
    else
      raise NoMethodError, "undefined method `#{method_name}' for #{self}:#{self.class}"
    end
  end
end

16.multiply_by_64 # вернёт 1024
16.multiply_by_x # ошибка NoMethodError
```

## Как работает метод `attr_accessor`?

Многие из нас используют `attr_accessor` в классах, однако не все понимают, какую работу он за нас выполняет. `attr_accessor` динамически генерирует *getter* и *setter* для переменной экземпляра. Давайте посмотрим на примере.

``` ruby
class Person
  attr_accessor :first_name
end

john = Person.new
john.first_name = 'John'
john.instance_variables # вернёт ["@first_name"]
john.methods.grep /first_name/ # вернёт ["first_name", "first_name="]
```

Также мы видим,  что `attr_accessor` создаёт переменную экземпляра `@first_name` и два метода: *getter* `first_name`и *setter* `first_name=`.

### Реализация

Все классы наследуют методы `Module`, поэтому мы поместим методы сюда.

``` ruby
class Module
  # First using define_method
  def attr1(symbol)
    instance_var = ('@' + symbol.to_s)
    define_method(symbol) { instance_variable_get(instance_var) }
    define_method(symbol.to_s + "=") { |val| instance_variable_set(instance_var, val) }
  end

  # Second using module_eval
  def attr2(symbol)
    module_eval "def #{symbol}; @#{symbol}; end"
    module_eval "def #{symbol}=(val); @#{symbol} = val; end"
  end
end

class Person
  attr1 :name
  attr2 :phone
end

person = Person.new
person.name = 'John Smith'
person.phone = '555-2344'
person # returns
```

`define_method` и `module_eval` оба вернут один и тот же результат.

## Пример использования: Active Record для бедных

Те, кто знаком с Ruby on Rails, уже догадываются, как можно реализовать класс `ActiveRecord`, который пройдётся по полям таблицы и добавит классу соответствующие методы *getter* и *setter* для полей таблицы.

Мы можем пойти дальше и динамически создать классы, соответствующие таблицам.

В этом примере мы создадим `ActiveRecord` для бедных. Этот класс соединится с базой данных MySQL, создаст динамически классы, соответствующие каждой таблице, а так же наполнит эти классы методами *getter* и *setter*, соответсвующими полям таблицы.

``` ruby
require 'rubygems'
require 'mysql'

class PoorMan
  # сохраним список сгенерированных классов в переменной класса
  class << self; attr_reader :generated_classes; end
  @generated_classes = []

  def initialize(attributes = nil)
    if attributes
      attributes.each_pair do |key, value|
        instance_variable_set('@' + key, value)
      end
    end
  end

  def self.connect(host, user, password, database)
    @@db = Mysql.new(host, user, password, database)

    # пройдёмся по списку таблиц и создадим классы для них
    @@db.list_tables.each do |table_name|
      class_name = table_name.split('_').collect { |word| word.capitalize }.join

      # создаём класс для таблицы, используя Module#const_set
      @generated_classes << klass = Object.const_set(class_name, Class.new(PoorMan))
      klass.module_eval do
        @@fields = []
        @@table_name = table_name

        def fields; @@fields; end
      end

      # пройдёмся по списку полей таблицы и создадим методы getter и setter для них
      @@db.list_fields(table_name).fetch_fields.each do |field|
        # добавляем getter и setter
        klass.send :attr_accessor, field.name

        # добавляем имя поля в список полей
        klass.module_eval { @@fields << field.name }
      end
    end
  end

  # получаем строку таблицы по идентификатору
  def self.find(id)
    result = @@db.query("select * from #{@@table_name} where id = #{id} limit 1")
    attributes = result.fetch_hash
    new(attributes) if attributes
  end

  # получаем все строки
  def self.all
    result = @@db.query("select * from #{@@table_name}")
    found = []
    while(attributes = result.fetch_hash) do
      found << new(attributes)
    end
    found
  end
end

# соединяем класс PoorMan с базой данных, всё остальное он сделает самостоятельно
PoorMan::connect('host', 'user', 'password', 'database')

# печатаем список сгенерированных классов
p PoorMan::generated_classes

# получаем пользователя с идентификатором 1
user = Users.find(1)

# получаем всех пользователей
Users.all
```

Оригинал статьи: <a href="http://weare.buildingsky.net/2009/08/25/rubys-metaprogramming-toolbox">Ruby’s metaprogramming toolbox</a>, автор — Corban Brook

Некоторые примеры могут не работать на Ruby < 1.8.7
