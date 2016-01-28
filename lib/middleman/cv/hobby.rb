require 'middleman/cv/object'

class Middleman::CV
  class Hobby < Object
    def initialize(cv, attrs = {})
      attrs = {title: attrs} if attrs.is_a?(String)
      super(cv, attrs)
    end

    attr_accessor :title

    def to_html
      content_tag(:li, content_tag(:i, nil, class: 'b-hobby__mark') << ' ' << title, class: 'b-hobby')
    end
  end
end
