namespace :test do
  desc "Run all cucumber features"
  task :prepare do
    system "bundle update"
    Rake::Task["db:create"].invoke
    Rake::Task["db:migrate"].invoke
    Rake::Task["db:test:prepare"].invoke
  end
end
