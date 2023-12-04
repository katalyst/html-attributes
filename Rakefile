# frozen_string_literal: true

require "bundler/setup"
require "bundler/gem_tasks"
require "rspec/core/rake_task"
require "rubocop/rake_task"

APP_RAKEFILE = File.expand_path("spec/dummy/Rakefile", __dir__)

RuboCop::RakeTask.new

desc "Run all linters"
task lint: %w[rubocop]

desc "Run all auto-formatters"
task format: %w[rubocop:autocorrect]

task default: %i[lint spec] do
  puts "🎉 build complete! 🎉"
end
