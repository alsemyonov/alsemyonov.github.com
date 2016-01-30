require 'middleman/cv/object'
require 'middleman/world'
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

    def location=(location)
      @location = Middleman::World::Location.new(@beholder, location || {})
    end

    def dates
      dates = [started_at, end_at].compact.join(' — ')
      dates
    end

    def started_at
      return unless start_date
      label = l(start_date, format: :month)
      label = label.mb_chars.downcase if I18n.locale == :ru
      content_tag(:time, label, itemprop: 'startDate', class: 'dt-start', datetime: start_date.xmlschema)
    end

    def end_at
      return t('cv.experience.until_now') if is_current || !end_date
      label = l(end_date, format: :month)
      label = label.mb_chars.downcase if I18n.locale == :ru
      content_tag(:time, label, itemprop: 'endDate', class: 'dt-end', datetime: end_date.xmlschema)
    end

    def responsibilities
      @responsibilities || []
    end

    def achievements
      @achievements || []
    end

    def skills
      @decorated_skills ||= (@skills || []).map { |skill| Skill.new(@beholder, skill) }
    end

    def <=>(other)
      to_comparable <=> other.to_comparable
    end

    def to_comparable
      [-start_date.to_time.to_i, -end_date.try(:to_time).to_i, title]
    end

    def status_icon
      content_tag(:i, nil, class: "b-experience__status b-experience__status_#{is_current ? 'current' : 'previous'}")
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
