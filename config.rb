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
    absolutize_url(url)
  end

  def absolutize_url(url)
    # url = data.site.baseurl + url
    # url = data.site.url + url
    url
  end
end

# Build-specific configuration
configure :build do
  # Minify CSS on build
  # activate :minify_css

  # Minify Javascript on build
  # activate :minify_javascript
end
