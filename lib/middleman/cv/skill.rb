require 'middleman/cv/object'

class Middleman::CV
  class Skill < Object
    def initialize(cv, attributes = {})
      @cv = cv
      attributes = { title: attributes } if attributes.is_a?(String)
      attributes[:children] ||= []
      super(cv, attributes)
    end

    attr_accessor :title
    attr_accessor :children

    def skills
      @skills ||= children.map { |child| Skill.new(@cv, child) }
    end

    def to_html
      attributes = {id: "skill-#{title.parameterize}", class: 'p-skill', itemprop: 'itemListElement'}
      result = if tags.include?(title)
                 link_to(title, tag_path(title), attributes)
               else
                 content_tag(:span, title, attributes)
               end
      if skills.any?
        result << content_tag(:ul, skills.map(&:to_html).join)
      end
      content_tag(:li, result)
    end
  end
end
