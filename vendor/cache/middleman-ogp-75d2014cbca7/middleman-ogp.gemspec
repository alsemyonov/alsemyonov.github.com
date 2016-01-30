# -*- encoding: utf-8 -*-
# stub: middleman-ogp 1.0.4 ruby lib

Gem::Specification.new do |s|
  s.name = "middleman-ogp"
  s.version = "1.0.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Atsushi Nagase"]
  s.date = "2016-01-30"
  s.description = "OpenGraph Protocol Helper for Middleman"
  s.email = ["a@ngs.io"]
  s.files = [".gitignore", ".travis.yml", "CHANGELOG.md", "CONTRIBUTING.md", "Gemfile", "LICENSE.md", "README.md", "Rakefile", "features/blog.feature", "features/helper.feature", "features/support/env.rb", "fixtures/test-app/config.rb", "fixtures/test-app/data/ogp/fb.yml", "fixtures/test-app/data/ogp/og.yml", "fixtures/test-app/source/index.html.slim", "fixtures/test-app/source/layout.slim", "fixtures/test-app/source/page.html.slim", "fixtures/test-blog/config.rb", "fixtures/test-blog/data/ogp/fb.yml", "fixtures/test-blog/data/ogp/og.yml", "fixtures/test-blog/source/2014-04-12-my-test.html.slim", "fixtures/test-blog/source/index.html.slim", "fixtures/test-blog/source/layout.slim", "lib/middleman-ogp.rb", "lib/middleman-ogp/extension.rb", "lib/middleman-ogp/middleman_extension.rb", "lib/middleman-ogp/version.rb", "middleman-ogp.gemspec", "spec/helper_spec.rb", "spec/spec_helper.rb"]
  s.homepage = "https://github.com/ngs/middleman-ogp"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.5.1"
  s.summary = "OpenGraph Protocol Helper for Middleman"
  s.test_files = ["features/blog.feature", "features/helper.feature", "features/support/env.rb", "fixtures/test-app/config.rb", "fixtures/test-app/data/ogp/fb.yml", "fixtures/test-app/data/ogp/og.yml", "fixtures/test-app/source/index.html.slim", "fixtures/test-app/source/layout.slim", "fixtures/test-app/source/page.html.slim", "fixtures/test-blog/config.rb", "fixtures/test-blog/data/ogp/fb.yml", "fixtures/test-blog/data/ogp/og.yml", "fixtures/test-blog/source/2014-04-12-my-test.html.slim", "fixtures/test-blog/source/index.html.slim", "fixtures/test-blog/source/layout.slim", "spec/helper_spec.rb", "spec/spec_helper.rb"]

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<middleman-core>, ["~> 4.0"])
    else
      s.add_dependency(%q<middleman-core>, ["~> 4.0"])
    end
  else
    s.add_dependency(%q<middleman-core>, ["~> 4.0"])
  end
end
