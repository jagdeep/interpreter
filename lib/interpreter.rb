module Interpreter
  autoload :Base, "interpreter/base"

  mattr_reader :backend
  @@backend = nil

  mattr_reader :locales
  @@locales = I18n.backend.available_locales

  class Engine < Rails::Engine
  end

  def self.setup
    yield self
  end

  def self.backend=(backend)
    @@backend = backend
    I18n.backend = I18n::Backend::Chain.new(I18n::Backend::KeyValue.new(@@backend), I18n.backend)
  end

  def self.locales=(locales = [])
    @@locales = locales
  end
end
