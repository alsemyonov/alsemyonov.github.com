#!/usr/bin/env ruby

if __FILE__ == $0

  require 'octokit'
  require 'yaml'
  require 'pathname'
  require 'active_support'
  require 'active_support/core_ext'

  ROOT = Pathname.new(File.expand_path('../..', __FILE__))
  PROJECTS_FILE = ROOT.join('_data/projects.yml')

  Octokit.auto_paginate = true

  @data = Hash.new { |hash, key| hash[key] = {} }

  YAML.load(File.read(PROJECTS_FILE)).each do |old|
    @data[old['name']] = old.symbolize_keys
  end

# Fetch a user
  @user = Octokit.user 'alsemyonov'
  puts @user.name

  @repositories = Octokit.repositories 'alsemyonov'

  @repositories.map do |repository|
    @data[repository.name]['description'] ||= repository[:description]
    @data[repository.name].merge!(repository.to_hash.slice(:name, :full_name, :language, :stargazers_count, :forks, :watchers))
  end

  File.write(PROJECTS_FILE, YAML.dump(@data.values.map(&:stringify_keys)))

  require 'irb'
  IRB.start
end
