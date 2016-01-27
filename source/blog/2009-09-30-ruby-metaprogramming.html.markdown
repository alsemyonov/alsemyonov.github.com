---
date: 2009-09-30 13:01
title: Метапрограммирование в Ruby
slug: ruby-metaprogramming
type: post
tags: Ruby, Метапрограммирование, Переводы, программирование
---

<h2>Что такое метапрограммирование?</h2>
<blockquote>Metaprogramming is the writing of computer programs that write or manipulate other programs (or themselves) as their data, or that do part of the work at compile time that would otherwise be done at runtime. In many cases, this allows programmers to get more done in the same amount of time as they would take to write all the code manually, or it gives programs greater flexibility to efficiently handle new situations without recompilation. (via Wikipedia)</blockquote>
Это руководство перечисляет все стандартные методы Ruby, используемые для метапрограммирования, а так же приводит примеры их обычного употребления. В конце мы получим пример использования метапрограммирования для динамического создания классов, соответствующих таблицам в БД, включающих методы, соответствующие полям таблицы, на манер <code class="ruby">ActiveRecord</code>.
<!--more-->
<h2>Инструментарий метапрограммиста</h2>
Ruby содержит множество методов для динамического создания кода. Ознакомимся с ними:
<h3>Получение, установка и удаление переменных</h3>
<ul>
	<li><code class="ruby">Object#instance_variable_get</code></li>
	<li><code class="ruby">Object#instance_variable_set</code></li>
	<li><code class="ruby">Object#remove_instance_variable</code></li>
	<li><code class="ruby">Module#class_variable_get</code></li>
	<li><code class="ruby">Module#class_variable_set</code></li>
	<li><code class="ruby">Module#remove_class_variable</code></li>
</ul>
<h3>Получение, установка и удаление констант (и классов)</h3>
<ul>
	<li><code class="ruby">Module#const_get</code></li>
	<li><code class="ruby">Module#const_set</code></li>
	<li><code class="ruby">Module#remove_const</code></li>
</ul>
<h3>Объявление и удаление методов</h3>
<ul>
	<li><code class="ruby">Module#define_method</code></li>
	<li><code class="ruby">Module#remove_method</code></li>
</ul>
<h3>Выполнение кода, построенного «на лету»</h3>
<ul>
	<li><code class="ruby">Object#send</code></li>
	<li><code class="ruby">Object#instance_eval</code></li>
	<li><code class="ruby">Module#module_eval (синоним Module#class_eval)</code></li>
	<li><code class="ruby">Kernel#eval</code></li>
	<li><code class="ruby">Kernel#method_missing</code></li>
</ul>
<h3>Методы интроспекции (рефлексии, отражения)</h3>
Интроспекция — важная часть метапрограммирования, позволяющая изучать объекты, получая их структуру и данные
<ul>
	<li><code class="ruby">Object#class</code></li>
	<li><code class="ruby">Object#instance_variables</code></li>
	<li><code class="ruby">Object#methods</code></li>
	<li><code class="ruby">Object#private_methods</code></li>
	<li><code class="ruby">Object#public_methods</code></li>
	<li><code class="ruby">Object#singleton_methods</code></li>
	<li><code class="ruby">Module#class_variables</code></li>
	<li><code class="ruby">Module#constants</code></li>
	<li><code class="ruby">Module#included_modules</code></li>
	<li><code class="ruby">Module#instance_methods</code></li>
	<li><code class="ruby">Module#name</code></li>
	<li><code class="ruby">Module#private_instance_methods</code></li>
	<li><code class="ruby">Module#protected_instance_methods</code></li>
	<li><code class="ruby">Module#public_instance_methods</code></li>
</ul>
<h2>Выполнение кода в строках и блоках</h2>
Вы могли слышать о методе eval, позволяющем выполнять строку или блок как код на Ruby. Когда нужно выполнить код внутри контекста какого-то объекта, можно использовать методы <code class="ruby">instance_eval</code> и <code class="ruby">module_eval</code> (синоним <code class="ruby">class_eval</code>).

Метод <code class="ruby">instance_eval</code> выполняет код в контексте существующего объекта.
<pre><code class="ruby">[1, 2, 3, 4].instance_eval('size') # вернёт 4</code></pre>
В примере мы передали методу <code>instance_eval</code> строку «size», что интерпретировалось как получение метода «size» массивом. Это эквивалентно следующему вызову:
<pre><code class="ruby">[1, 2, 3, 4].size</code></pre>
Кроме того, вы можете передавать методу <code>instance_eval</code> блок.
<pre><code class="ruby"># Получаем среднее арифметическое чисел в массиве
[1, 2, 3, 4].instance_eval { inject(:+) / size.to_f } # вернёт 2.5</code></pre>
<code class="ruby">Методы inject(:+)</code>и <code class="ruby">size.to_f</code> вроде бы «висят в воздухе» и не относятся ни к какому объекту, однако они выполняются в блоке, в контексте объекта, поэтому они интерпретируются как <code class="ruby">self.inject(:+)</code> / <code class="ruby">self.size.to_f</code> где self — наш массив.

В то время как <code class="ruby">instance_eval</code> выполняет код в контексте объекта, метод <code class="ruby">module_eval</code> выполняет код в контексте модуля или класса.
<pre><code class="ruby">Fixnum.module_eval do
  def to_word
    if (0..3).include? self
      ['ничего', 'один', 'пара', 'несколько'][self]
    elsif self &gt; 3
      'много'
    elsif self &lt; 0
      'отрицательно'
    end
  end
end
1.to_word # вернёт 'один'
2.to_word # вернёт 'пара'
</code></pre>
Мы видим, как <code class="ruby">module_eval</code> заново открывает существующий класс <code class="ruby">Fixnum</code> и добавляет в него новый метод. Само по себе это не очень интересно, и мы можем сделать это иначе:
<pre><code class="ruby">class Fixnum
  def to_word
    ..
  end
end</code></pre>
Лучшее применение этому методу мы найдём при динамическом генерировании кода. Добавим метод <code class="ruby">create_multiplier</code>, который позволит динамически генерировать методы-умножители с теми именами, которые вы захотите.
<pre><code class="ruby">class Fixnum
  def self.create_multiplier(name, num)
    module_eval "def #{name}; self * #{num}; end"
  end
end

Fixnum.create_multiplier('multiply_by_pi', Math::PI)
4.multiply_by_pi # вернёт 12.5663706143592 </code></pre>
Пример выше создаёт метод класса (или  «метод-синглетон») <code class="ruby">create_multiplier</code>, с помощью которого мы сможем создавать методы, применимые к любому объекту класса <code class="ruby">Fixnum</code>.
<h2>Использование <code class="ruby">send</code></h2>
Метод <code class="ruby">send</code> работает почти как <code class="ruby">instance_eval</code>, поскольку вызывает метод объекта, переданный в качестве параметра. Он удобен, когда мы динамически получаем имя необходимого метода в виде строки или символа.
<pre><code class="ruby">method_name = 'size'
[1, 2, 3, 4].send(method_name) # вернёт 4</code></pre>
Мы можем передать имя метода в виде строки <code class="ruby">'size'</code> или символа <code class="ruby">:size</code>

Полезное свойство метода <code class="ruby">send</code> — возможность вызывать приватные методы, как например метод <code class="ruby">Module#define_method</code>.
<pre><code class="ruby">Array.define_method(:ducky) { puts 'ducky' }
# NoMethodError: private method `define_method' called for Array:Class</code></pre>
Используя <code class="ruby">send</code> получаем:
<pre><code class="ruby">Array.send(:define_method, :ducky) { puts 'ducky' }</code></pre>
<h2>Создание методов</h2>
Как мы видим в примере выше, мы можем создавать методы классов с помощью <code class="ruby">define_method</code>.
<pre><code class="ruby">class Array
  define_method(:multiply) do |arg|
    collect{|i| i * arg}
  end
end

[1, 2, 3, 4].multiply(16) # returns [16, 32, 48, 64]</code></pre>
<h2>method_missing</h2>
Метод <code class="ruby">method_missing</code>, объявленный в классе, вызывается в случае получения экземпляром класса несуществующего метода. Это может быть использовано для выполнения этих отсутвующих методов, вместо отправки ошибки <code class="ruby">NoMethodError</code>.
<pre><code class="ruby">class Fixnum
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
16.multiply_by_x # ошибка NoMethodError</code></pre>
<h2>Как работает метод <code class="ruby">attr_accessor</code>?</h2>
Многие из нас используют <code class="ruby">attr_accessor</code> в классах, однако не все понимают, какую работу он за нас выполняет. <code class="ruby">attr_accessor</code> динамически генерирует <em>getter</em> и <em>setter</em> для переменной экземпляра. Давайте посмотрим на примере.
<pre><code class="ruby">class Person
  attr_accessor :first_name
end

john = Person.new
john.first_name = 'John'
john.instance_variables # вернёт ["@first_name"]
john.methods.grep /first_name/ # вернёт ["first_name", "first_name="]</code></pre>
Также мы видим,  что <code class="ruby">attr_accessor</code> создаёт переменную экземпляра <code class="ruby">@first_name</code> и два метода: <em>getter</em> <code>first_name</code>и <em>setter</em> <code class="ruby">first_name=</code>
<h3>Реализация</h3>
Все классы наследуют методы <code class="ruby">Module</code>, поэтому мы поместим методы сюда.
<pre><code class="ruby">class Module
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
person # returns</code></pre>
<code class="ruby">define_method</code> и <code class="ruby">module_eval</code> оба вернут один и тот же результат.
<h2>Пример использования: Active Record для бедных</h2>
Те, кто знаком с Ruby on Rails, уже догадываются, как можно реализовать класс <code class="ruby">ActiveRecord</code>, который пройдётся по полям таблицы и добавит классу соответствующие методы <em>getter</em> и <em>setter</em> для полей таблицы.

Мы можем пойти дальше и динамически создать классы, соответствующие таблицам.

В этом примере мы создадим <code class="ruby">ActiveRecord</code> для бедных. Этот класс соединится с базой данных MySQL, создаст динамически классы, соответствующие каждой таблице, а так же наполнит эти классы методами <em>getter</em> и <em>setter</em>, соответсвующими полям таблицы.
<pre><code class="ruby">require 'rubygems'
require 'mysql'

class PoorMan
  # сохраним список сгенерированных классов в переменной класса
  class &lt;&lt; self; attr_reader :generated_classes; end
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
      @generated_classes &lt;&lt; klass = Object.const_set(class_name, Class.new(PoorMan))
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
        klass.module_eval { @@fields &lt;&lt; field.name }
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
      found &lt;&lt; new(attributes)
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
Users.all</code></pre>
Оригинал статьи: <a href="http://weare.buildingsky.net/2009/08/25/rubys-metaprogramming-toolbox">Ruby’s metaprogramming toolbox</a>, автор — Corban Brook

Некоторые примеры могут не работать на Ruby &lt; 1.8.7
