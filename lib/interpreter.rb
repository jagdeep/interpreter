module Interpreter
  autoload :Translation, "interpreter/translation"

  mattr_reader :backend
  @@backend = nil

  class Engine < Rails::Engine
  end

  def self.setup
    yield self
  end

  def self.backend=(backend)
    @@backend = backend
    I18n.backend = I18n::Backend::Chain.new(I18n::Backend::KeyValue.new(@@backend), I18n.backend)
  end
end
