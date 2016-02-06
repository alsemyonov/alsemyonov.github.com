require 'middleman/world'
require 'middleman/data_object'

module Middleman
  class World
    class Object < DataObject
      attr_accessor :name

      def self.partial_name
        "world/#{local_name}"
      end

      delegate :present?, to: :name
    end
  end
end
