require 'middleman/world/object'

module Middleman
  class World
    class Location < Object
      attr_reader :country
      attr_reader :locality
      attr_accessor :region
      attr_accessor :name

      def country=(country)
        @country = Country.new(@beholder, country)
      end

      def locality=(locality)
        @locality = Locality.new(@beholder, locality)
      end

      def present?
        super || country.present? || locality.present?
      end

      def to_meta(prop = :location)
        result = ''
        result += tag(:meta, itemprop: 'addressLocality', content: locality.name) if locality
        result += tag(:meta, itemprop: 'addressCountry', content: country.name) if country
        if name
          result += tag(:meta, itemprop: 'name', content: name)
        end
        content_tag(:span, result, itemprop: prop, itemscope: true, itemtype: 'http://schema.org/PostalAddress')
      end
    end
  end
end
