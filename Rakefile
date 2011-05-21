require 'bundler'
Bundler::GemHelper.install_tasks

task :default => :test

namespace :test do
  desc "Run all cucumber features"
  task :cukes do
    system "cucumber test/dummy/features"
  end

  desc "Run bundle install and prepare database for tests"
  task :prepare do
    system "rake test:prepare -f test/dummy/Rakefile"
  end
end

require 'rake/testtask'

Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = false
end
