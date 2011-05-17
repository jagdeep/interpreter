Interpreter.setup do |config|
  config.backend = Redis.new
  config.locales = [:en, :pt, :sp]
end
