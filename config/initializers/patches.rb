require 'middleman-blog'
require 'middleman-blog/uri_templates'
require 'russian'

module Middleman
  module Blog
    module UriTemplates
      # Parameterize a string preserving any multibyte characters
      def safe_parameterize(str)
        sep = '-'

        # Reimplementation of http://api.rubyonrails.org/classes/ActiveSupport/Inflector.html#method-i-parameterize that preserves un-transliterate-able multibyte chars.
        parameterized_string = ActiveSupport::Inflector.transliterate(str.to_s).downcase
        parameterized_string.gsub!(/[^a-z0-9\-_\?]+/, sep)

        # parameterized_string.chars.to_a.each_with_index do |char, i|
        #   if char == '?' && str[i].bytes.count != 1
        #     parameterized_string[i] = str[i]
        #   end
        # end

        re_sep = Regexp.escape(sep)
        # No more than one of the separator in a row.
        parameterized_string.gsub!(/#{re_sep}{2,}/, sep)
        # Remove leading/trailing separator.
        parameterized_string.gsub!(/^#{re_sep}|#{re_sep}$/, '')

        parameterized_string
      end
    end
  end
end

require 'i18n'
module I18n
  LANGUAGE_TERRITORIES = {
    en: 'en_US',
    ru: 'ru_RU'
  }.freeze

  def language_territory
    LANGUAGE_TERRITORIES[locale.to_sym]
  end

  module_function :language_territory
end

require 'middleman-deploy/strategies/git/base'
module Middleman
  module Deploy
    module Strategies
      module Git
        class Base
          protected

          def add_signature_to_commit_message(base_message)
            signature = "#{Middleman::Deploy::PACKAGE} #{Middleman::Deploy::VERSION}"
            time      = "#{Time.now.utc}"

            "#{base_message} at #{time} by #{signature} [skip ci]"
          end
        end
      end
    end
  end
end

