require 'active_support'
require 'i18n'
require 'russian'
require 'lib/patches'

# General configuration

Time.zone = 'St. Petersburg'

# Default locale is ru_RU, en_US is under /en/ directory.
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
  activate :gzip
  # Uniquely-named assets
  activate :asset_hash
end

set :slim, { format: :html, pretty: false }
set :markdown_engine, :redcarpet
