require 'middleman/cv/object'

class Middleman::CV
  class Skill < Object
    def initialize(beholder, attributes = {})
      attributes = { title: attributes } if attributes.is_a?(String)
      attributes[:children] ||= []
      super(beholder, attributes)
    end

    attr_accessor :title
    attr_accessor :children

    def skills
      @skills ||= children.map { |child| Skill.new(@beholder, child) }
    end

    def to_html
      attributes = {id: "skill-#{title.parameterize}", class: 'b-skill p-skill', itemprop: 'itemListElement'}
      result = if tags.include?(title)
                 link_to(title, tag_path(title), attributes)
               else
                 content_tag(:span, title, attributes)
               end
      result = content_tag(:i, nil, class: 'b-skill__mark') << result
      if skills.any?
        result << content_tag(:ul, skills.map(&:to_html).join, class: 'b-skills-list')
      end
      content_tag(:li, result)
    end
  end
end
