source 'https://rubygems.org/'

gem 'dotenv'

# For faster file watcher updates on Windows:
gem 'wdm', '~> 0.1.0', platforms: [:mswin, :mingw]

# Windows does not come with time zone data
gem 'tzinfo-data', platforms: [:mswin, :mingw, :jruby]

## Core
gem 'middleman', '~> 4.1.1'

## OGP
gem 'middleman-ogp', git: 'https://github.com/alsemyonov/middleman-ogp', branch: :master

## Blogging
gem 'middleman-blog'

## Web Standards
gem 'weby', git: 'https://github.com/alsemyonov/weby', branch: :master

## Livereload in development
gem 'middleman-livereload'

# Post-process
gem 'middleman-minify-html'

# General
gem 'activesupport'
gem 'russian'

# Templates
gem 'slim'
gem 'redcarpet', '~> 3.3', '>= 3.3.3'
gem 'builder', '~> 3.0'

group :development do
  # Interactions
  gem 'octokit'
  gem 'linkedin'

  # Console
  gem 'pry'
end

## Assets
gem 'middleman-autoprefixer'
gem 'middleman-sprockets', '~> 4.0.0.rc.1', git: 'https://github.com/middleman/middleman-sprockets.git'
gem 'bootstrap', '~> 4.0.0.alpha3'
gem 'font-awesome-sass'
source 'https://rails-assets.org/' do
  gem 'rails-assets-tether'
  gem 'rails-assets-jquery'
end

group :test do
  # Test tools
  gem 'cucumber', '~> 2.0', require: false
  gem 'aruba', '~> 0.7.4', require: false
  gem 'rspec', '~> 3.0', require: false
  gem 'rspec-its', '~> 1.2.0', require: false

  gem 'timecop', '~> 0.8.0'
  gem 'nokogiri'
end
