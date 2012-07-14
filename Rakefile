#!/usr/bin/env rake

begin
  require "rspec/core/rake_task"
  require "bundler/gem_tasks"

  desc "Run all of the tests / specs in the project"
  RSpec::Core::RakeTask.new(:test) do |t|
    spec_dir = File.join File.dirname(__FILE__), 'spec'
    t.pattern = "#{spec_dir}/*_spec.rb"
  end
rescue LoadError
end
