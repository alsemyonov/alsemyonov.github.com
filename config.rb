require './lib/patches.rb'
Time.zone = 'St. Petersburg'

###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

# With alternative layout
# page "/path/to/file.html", layout: :otherlayout

# Proxy pages (http://middlemanapp.com/basics/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", locals: {
#  which_fake_page: "Rendering a fake page with a local variable" }

# General configuration

# Reload the browser automatically whenever files change
configure :development do
  activate :livereload
  set :slim, { ugly: false, format: :html }
end

activate :directory_indexes

require 'i18n'
require 'russian'
I18n.default_locale = :ru
I18n.locale = :ru
activate :i18n,
         mount_at_root: :ru,
         path: '/:locale/',
         locales: [:ru, :en]

activate :blog do |blog|
  # This will add a prefix to all links, template references and source paths
  blog.prefix = 'blog'

  # blog.permalink = "{year}/{month}/{day}/{title}.html"
  # Matcher for blog source files
  # blog.sources = "{year}-{month}-{day}-{title}.html"
  # blog.taglink = "tags/{tag}.html"
  blog.layout = 'post'
  # blog.summary_separator = /(READMORE)/
  # blog.summary_length = 250
  # blog.year_link = "{year}.html"
  # blog.month_link = "{year}/{month}.html"
  # blog.day_link = "{year}/{month}/{day}.html"
  # blog.default_extension = ".markdown"

  blog.tag_template = 'tag.html'
  blog.calendar_template = 'calendar.html'

  # Enable pagination
  blog.paginate = true
  blog.per_page = 10
  blog.page_link = 'page/{num}'

  blog.custom_collections = {
    category: {
      link: '/categories/{category}.html',
      template: 'category.html'
    }
  }
  page "#{blog.prefix}/atom.xml", layout: false
  page '#{blog.prefix}/rss.xml', layout: false
end

###
# Helpers
###
# Methods defined in the helpers block are available in templates
helpers do
  def cgi_escape(string)
    CGI::escape(string)
  end

  def make_excerpt(text)
    # text = text.strip_html
    # text = text.strip_newlines
    # text.truncate(60)
    text
  end

  def canonicalize_url(url)
    url = url.gsub('index.html', '')
    absolute_url(url)
  end

  def absolute_url(url)
    # url = root_url + url
    # url = data.site.url + url
    URI.join(data.site.url, url)
  end

  def format_date(date, format = nil)
    date.to_s(format)
  end

  def navigation_resources
    sitemap.resources.select do |resource|
      resource.data.navigation == true &&
        (!resource.locals['page_number'] || (resource.locals['page_number'] == 1)) &&
        !resource.locals['category']
    end.sort_by { |resource| resource.data.priority }
  end

  def root_path(*paths)
    uri_root_path(*paths)
  end

  def l(date, options)
    ::I18n.localize(date, options)
  end
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
  set :slim, { ugly: true, format: :html }
end
