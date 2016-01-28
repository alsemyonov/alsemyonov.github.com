require 'middleman/cv/object'
require 'active_support/core_ext/string/multibyte'

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

    def location
      (@location || {})['name']
    end

    def dates
      dates = [started_at, end_at].compact.join(' — ')
      dates = dates.mb_chars.downcase if I18n.locale == :ru
      dates
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
      content_tag(:section, class: "b-experience__list b-experience__list_#{property}", itemtype: 'http://schema.org/ItemList', itemscope: true) do
        list_items = values.map do |value|
          value.respond_to?(:to_html) ? value.to_html : content_tag(:li, content_tag(:i, nil) << value, itemprop: 'itemListElement')
        end.join
        content_tag(:p, t(property, scope: 'cv.experience'), class: 'b-experience__list-title', itemprop: 'name') <<
          content_tag(:ul, list_items)
      end if values.any?
    end
  end
end
