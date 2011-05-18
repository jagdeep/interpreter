Interpreter.setup do |config|
  config.backend = Redis.new(:db => 9)
  config.locales = [:en, :pt, :es]
end
