require 'middleman'
require 'middleman/data_object'

module Middleman
  class World
    extend ActiveSupport::Autoload

    autoload :Locality
    autoload :Location
    autoload :Country
    autoload :Object
  end
end
