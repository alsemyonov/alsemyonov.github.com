module Middleman
  class CV
    extend ActiveSupport::Autoload

    autoload :Skill
    autoload :Language
    autoload :Experience
    autoload :Object
    autoload :Hobby

    def initialize(template_context)
      @template_context = template_context
    end

    attr_reader :template_context

    delegate :data, :content_tag, to: :template_context

    def about
      data.cv.about[I18n.locale]
    end

    # @return [<String>]
    def tags
      @tags ||= @template_context.blog.tags.keys
    end

    # @return [<Skill>]
    def skills
      @skills ||= data.cv.skills.map { |skill| Skill.new(self, skill) }
    end

    # @return [<Language>]
    def languages
      @languages ||= data.cv.languages.map { |locale, level| Language.new(self, locale: locale, level: level) }
    end

    # @return [<Experience>]
    def experiences
      @experiences ||= data.cv.experience.map { |experience| Experience.new(self, experience) }.sort
    end

    # @return [<Experience>]
    def hobbies
      @hobbies ||= data.cv.hobbies.map { |hobby| Hobby.new(self, hobby) }
    end

    def list_of(property, options = {})
      content_tag(:ul, public_send(property).map(&:to_html).join, {class: "b-#{property}-list"}.merge(options))
    end
  end
end
