PROJECT_ROOT_PATH = File.dirname(File.dirname(__FILE__))

require 'rubygems'
require File.join(PROJECT_ROOT_PATH, 'lib', 'middleman-ogp')
require File.join(PROJECT_ROOT_PATH, 'lib', 'middleman-ogp/extension')

class String
  def unindent
    gsub(/^#{scan(/^\s*/).min_by{|l|l.length}}/, "").sub(/\n$/, '')
  end
end

RSpec.configure do |config|
  config.expect_with(:rspec) { |c| c.syntax = [:should, :expect] }
end
