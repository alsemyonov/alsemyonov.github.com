require 'middleman'

module Middleman
  class DataObject
    def self.local_name
      name.demodulize.underscore
    end

    def self.partial_name
      local_name
    end

    def initialize(beholder, attributes = {})
      @beholder = beholder
      @attributes = {}
      attributes.each do |key, value|
        writer = "#{key}="
        respond_to?(writer) ? public_send(writer, value) : @attributes[key] = value
      end
    end

    attr_accessor :name

    delegate :template_context, :tags,
             to: :@beholder

    delegate :tag_path, :link_to, :content_tag, :tag, :partial, :t, :l, :cycle,
             to: :template_context

    delegate :local_name, :partial_name,
             to: 'self.class'

    def to_html(partial = partial_name)
      partial(partial, locals: { local_name => self })
    end
  end
end
