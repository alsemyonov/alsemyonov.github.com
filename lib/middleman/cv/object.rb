require 'middleman/cv'
require 'middleman/data_object'

class Middleman::CV::Object < Middleman::DataObject
  def self.partial_name
    "cv/#{local_name}"
  end
end
