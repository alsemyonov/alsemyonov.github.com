require 'middleman/cv'

class Middleman::CV::Object
  def initialize(cv, attributes = {})
    @cv = cv
    @attributes = {}
    attributes.each do |key, value|
      writer = "#{key}="
      respond_to?(writer) ? public_send(writer, value) : @attributes[key] = value
    end
  end

  delegate :template_context, :tags, to: :@cv

  delegate :tag_path, :link_to, :content_tag, :partial, :t, :l, :cycle,
           to: :template_context

  def self.local_name
    name.demodulize.underscore
  end

  def self.partial_name
    "cv/#{local_name}"
  end

  delegate :local_name, :partial_name, to: 'self.class'

  def to_html
    partial(partial_name, locals: {local_name => self})
  end
end
