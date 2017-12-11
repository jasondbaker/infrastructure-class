# -*- mode: ruby -*-
# vi: set ft=ruby :
require 'bundler/setup'
require 'emeril/rake'

namespace :style do
  require 'rubocop/rake_task'
  desc 'Run rubocop for Ruby style checks'
  RuboCop::RakeTask.new(:ruby)

  require 'foodcritic'
  desc 'Run foodcritic for Chef style checks'
  FoodCritic::Rake::LintTask.new(:chef) do |t|
    t.options = { :fail_tags => ['correctness'] }
  end
end

desc 'Run all style checks'
task style: ['style:chef', 'style:ruby']

require 'rspec/core/rake_task'
desc 'Run ChefSpec unit tests'
RSpec::Core::RakeTask.new(:unit) do |t|
  t.rspec_opts = "--color --format progress"
end

namespace :travis do
  desc "run on Travis"
  task ci: ['unit']
end
