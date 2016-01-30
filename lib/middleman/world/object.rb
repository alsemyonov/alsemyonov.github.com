require 'middleman/world'
require 'middleman/data_object'

module Middleman
  class World
    class Object < DataObject
      attr_accessor :name

      def self.partial_name
        "world/#{local_name}"
      end

      def present?
        name.present?
      end
    end
  end
end
