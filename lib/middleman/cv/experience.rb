require 'middleman/cv/object'

class Middleman::CV
  class Experience < Object
    include Comparable

    attr_accessor :company
    attr_accessor :id
    attr_accessor :is_current
    attr_accessor :location
    attr_accessor :start_date
    attr_accessor :end_date
    attr_accessor :title
    attr_accessor :summary
    attr_writer :responsibilities
    attr_writer :achievements
    attr_writer :skills

    def dates
      [started_at, end_at].compact.join(' — ')
    end

    def started_at
      return unless start_date
      l(start_date, format: :month)
    end

    def end_at
      return t('cv.experience.until_now') if is_current || !end_date
      l(end_date, format: :month)
    end

    def responsibilities
      @responsibilities || []
    end

    def achievements
      @achievements || []
    end

    def skills
      @decorated_skills ||= (@skills || []).map { |skill| Skill.new(@cv, skill) }
    end

    def <=>(other)
      to_comparable <=> other.to_comparable
    end

    def to_comparable
      [-start_date.to_time.to_i, -end_date.try(:to_time).to_i, title]
    end

    def list_property(property)
      values = public_send(property).compact
      content_tag(:section, class: "b-experience__list b-experience__list_#{property}") do
        content_tag(:p, t(property, scope: 'cv.experience'), class: 'b-experience__list-title') <<
          content_tag(:ul, values.map { |value| value.respond_to?(:to_html) ? value.to_html : content_tag(:li, value) }.join)
      end if values.any?
    end
  end
end
