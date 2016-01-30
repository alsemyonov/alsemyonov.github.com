require 'active_support'
require 'i18n'
require 'russian'
require 'dotenv'
require './config/initializers/patches'

# General configuration

Dotenv.load!('.env')
Time.zone = 'St. Petersburg'

# Default locale is ru_RU, en_US is under /en/ directory.
I18n.default_locale = :ru
I18n.default_locale = :ru
I18n.locale = :ru
activate :i18n, mount_at_root: :ru, path: '/:locale/', locales: [:ru, :en]

activate :directory_indexes

# Development-specific configuration
configure :development do
  activate :livereload
end

# Build-specific configuration
configure :build do
  activate :autoprefixer
  # Minify CSS on build
  activate :minify_css
  # Minify Javascript on build
  activate :minify_javascript
  # Minify Javascript on build
  activate :minify_html
  # Provide GZipped versions of files
  activate :gzip, exts: %w(.js .css .html .htm .xml)
  # # Uniquely-named assets
  # activate :asset_hash
end

set :slim, { format: :html, pretty: false }

require 'redcarpet'
require 'redcarpet/render/html_abbreviations'

class SmartRenderer < Redcarpet::Render::SmartyHTML
  include Redcarpet::Render::HTMLAbbreviations
end

set :markdown_engine, :redcarpet
set :markdown, {
  strikethrough: true,
  autolink: true,
  highlight: true,
  underline: true,
  superscript: true,
  footnotes: true,
  tables: true,
  fenced_code_blocks: true,
  renderer: SmartRenderer,
  smartypants: true
}
