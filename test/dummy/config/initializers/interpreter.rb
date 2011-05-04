Interpreter.setup do |config|
  config.backend = Redis.new
end
