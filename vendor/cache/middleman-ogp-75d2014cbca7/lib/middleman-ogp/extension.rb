require 'temple/html/safe'
require 'padrino-helpers/tag_helpers'
require 'active_support/core_ext/module/attribute_accessors'
require 'backports/rails/hash'

module Middleman
  module OGP
    class OGPExtension < Extension
      option :namespaces, {}, 'Default namespaces'
      option :blog, false, 'Middleman Blog support'
      option :auto, %w{title url description}, 'Properties to automatically fill from page data.'
      option :base_url, nil, 'Base URL to generate permalink for og:url'

      def after_configuration
        Middleman::OGP::Helper.namespaces = options[:namespaces] || {}
        Middleman::OGP::Helper.blog = options[:blog]
        Middleman::OGP::Helper.auto = options[:auto]
        Middleman::OGP::Helper.base_url = options[:base_url]
      end

      helpers do
        def ogp_tags(&block)
          opts = current_resource.data['ogp'] || {}
          is_blog_article = Middleman::OGP::Helper.blog && respond_to?(:is_blog_article?) && is_blog_article?
          if is_blog_article
            opts.deep_merge4!({
                                og: {
                                  type: 'article',
                                },
                                article: {
                                  published_time: current_article.date.to_time.utc.iso8601,
                                  tag: current_article.tags,
                                }
                              })
          end
          opts[:og] ||= {}
          if ogp_include?('title')
            if current_resource.data['title']
              opts[:og][:title] ||= current_resource.data['title']
            elsif content_for?(:title)
              opts[:og][:title] ||= yield_content(:title)
            end
          end
          if ogp_include?('description')
            if current_resource.data['description']
              opts[:og][:description] ||= current_resource.data['description']
            elsif content_for?(:description)
              opts[:og][:description] ||= yield_content(:description)
            end
          end
          if ogp_include?('url') &&
            Middleman::OGP::Helper.base_url
            opts[:og][:url] ||= URI.join(Middleman::OGP::Helper.base_url, URI.encode(current_resource.url))
          end

          if block_given?
            Middleman::OGP::Helper.ogp_tags(opts, data.ogp, &block)
          else
            Middleman::OGP::Helper.ogp_tags(opts, data.ogp) do |name, value|
              concat_content tag(:meta, name: name, property: value)
            end
          end
        end

        private

        def ogp_include?(property)
          Middleman::OGP::Helper.auto.include?(property)
        end
      end
    end

    module Helper
      include Padrino::Helpers::TagHelpers
      mattr_accessor :namespaces
      mattr_accessor :blog
      mattr_accessor :auto
      mattr_accessor :base_url

      def self.ogp_tags(opts = {}, data, &block)
        opts ||= {}
        options = data.dup.stringify_keys
        opts.stringify_keys!
        options = options.deep_merge4(opts) { |k, old_value, new_value|
          if old_value.is_a?(Hash)
            if new_value.is_a? Hash
              old_value.deep_merge4 new_value
            else
              old_value[''] = new_value
              old_value
            end
          else
            new_value
          end
        }.symbolize_keys
        options.map { |k, v|
          self.og_tag([], v, k, &block)
        }.join("\n")
      end

      def self.og_tag(key, obj = nil, prefix = 'og', &block)
        case key
        when String, Symbol
          key = [key]
        when Hash
          prefix = obj if obj
          obj = key
          key = []
        end
        case obj
        when Hash
          obj.map { |k, v|
            og_tag(k.to_s.empty? ? key.dup : (key.dup << k.to_s), v, prefix, &block)
          }.join("\n")
        when Array
          obj.map { |v|
            og_tag(key, v, prefix, &block)
          }.join("\n")
        else
          block.call [prefix].concat(key).join(':'), obj.to_s
        end
      end

    end
  end
end


class Hash

  def deep_merge4(other_hash, &block)
    dup.deep_merge4!(other_hash, &block)
  end

  def deep_merge4!(other_hash, &block)
    other_hash.each_pair do |k, v|
      tv = self[k]
      if tv.is_a?(Hash) && v.is_a?(Hash)
        self[k] = tv.deep_merge4(v, &block)
      else
        self[k] = block && tv ? block.call(k, tv, v) : v
      end
    end
    self
  end

end
