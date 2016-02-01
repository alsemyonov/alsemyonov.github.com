# Per-page layout changes:
#
# With no layout
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false
page '/sitemap.xml', layout: false

# With alternative layout
# page "/path/to/file.html", layout: :otherlayout

# Proxy pages (http://middlemanapp.com/basics/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", locals: {
#  which_fake_page: "Rendering a fake page with a local variable" }

activate :blog do |blog|
  blog.name = 'blog'
  # This will add a prefix to all links, template references and source paths
  blog.prefix = 'blog'

  # blog.permalink = "{year}/{month}/{day}/{title}.html"
  # Matcher for blog source files
  blog.sources = '{year}/{month}/{day}/{title}.html'
  # blog.taglink = "tags/{tag}.html"
  blog.layout = 'post'
  # blog.summary_separator = /(READMORE)/
  # blog.summary_length = 250
  # blog.year_link = "{year}.html"
  # blog.month_link = "{year}/{month}.html"
  # blog.day_link = "{year}/{month}/{day}.html"
  # blog.default_extension = ".markdown"

  blog.tag_template = 'blog/tag.html'
  blog.calendar_template = 'blog/calendar.html'

  # Enable pagination
  blog.paginate = true
  blog.per_page = 10
  blog.page_link = 'page/{num}'

  blog.custom_collections = {
    category: {
      link: '/categories/{category}.html',
      template: 'blog/category.html'
    }
  }
end

activate :weby
