require 'pathname'
SOURCE_ROOT = Pathname.new(File.expand_path('..', __FILE__)).realpath
$LOAD_PATH << File.join(SOURCE_ROOT, 'lib')
ENV['BUNDLE_GEMFILE'] ||= SOURCE_ROOT.join('Gemfile')
require 'rubygems'
require 'bundler/setup'
Bundler.require(:default)

require 'dotenv'
Dotenv.load!('.env') if File.exist?('.env')

require 'active_support'
require './config/initializers/patches'

## Configuration
config[:time_zone] = 'St. Petersburg'

## Global modules

# Default locale is ru_RU, en_US is under /en/ directory.
require 'i18n'
require 'russian'
I18n.default_locale = :ru
I18n.locale = :ru
activate :i18n, mount_at_root: :ru, path: '/:locale/', locales: [:ru, :en]
activate :ogp do |ogp|
  ogp.namespaces = {
    twitter: data.ogp.twitter,
    # from data/ogp/fb.yml
    fb: data.ogp.fb,
    # from data/ogp/fb.yml
    og: data.ogp.og
    # from data/ogp/og.yml
  }
  ogp.base_url = ENV['URL']
  ogp.blog = true
end
activate :sprockets
activate :weby

# require './helpers/coder_wall_helpers'
# config[:achievements] = CoderWallHelpers.achievements_of('alsemyonov')

## Routes

# Per-page layout changes:
#
# With no layout
page '/*.xml', layout: false
page '/*.atom', layout: false
page '/*.rss', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

# With alternative layout
# page "/path/to/file.html", layout: :otherlayout

# Proxy pages (http://middlemanapp.com/basics/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", locals: {
#  which_fake_page: "Rendering a fake page with a local variable" }

activate :blog do |blog|
  # Matcher for blog source files
  blog.sources = '{year}/{month}/{day}/{title}.html'
  blog.permalink = '{year}/{month}/{day}/{title}.html'
  blog.layout = 'article'

  blog.tag_template = 'blog/tag.html'
  blog.taglink = 'tags/{tag}.html'

  blog.calendar_template = 'blog/calendar.html'
  blog.year_link = '{year}/index.html'
  blog.month_link = '{year}/{month}/index.html'
  blog.day_link = '{year}/{month}/{day}/index.html'

  # blog.summary_separator = /(READMORE)/
  # blog.summary_length = 250
  blog.default_extension = '.md'

  # Enable pagination
  blog.paginate = true
  blog.per_page = 10
  blog.page_link = 'page/{num}'

  blog.custom_collections = {
    category: {
      link: '/categories/{category}.html',
      template: 'blog/category.html'
    },
    # category_feed_atom: {
    #   link: '/categories/{category}.atom',
    #   template: 'index.atom.builder'
    # },
    # category_feed_tss: {
    #   link: '/categories/{category}.rss',
    #   template: 'index.rss.builder'
    # }
  }
end

# activate :directory_indexes

# ignore /^about\/webmaster.html$/
# ignore /^sitemap.html$/

activate :deploy do |deploy|
  deploy.deploy_method = :git
  # Optional Settings
  deploy.remote = 'origin' # remote name or git url, default: origin
  deploy.branch = 'master' # default: gh-pages
  deploy.strategy = :force_push # commit strategy: can be :force_push or :submodule, default: :force_push
  # deploy.commit_message = 'custom-message'      # commit message (can be empty), default: Automated commit at `timestamp` by middleman-deploy `version`
end
