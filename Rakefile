require 'bundler'
Bundler::GemHelper.install_tasks

task :default => "test:all"

namespace :test do
  desc "Run all cucumber features"
  task :all do
    system "cucumber test/dummy/features"
  end

  desc "Run bundle install and prepare database for tests"
  task :prepare do
    system "rake test:prepare -f test/dummy/Rakefile"
  end
end
