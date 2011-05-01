class Interpreter::Translation
  attr_reader :locale, :key, :value

  def initialize locale, key, value
    @locale = locale
    @key = key
    @value = value
  end

  def self.all
    collection = []
    Interpreter.backend.keys.each do |key|
      collection << self.new(key.split('.')[0], key, Interpreter.backend[key])
    end
    return collection.sort{|a, b| a.key <=> b.key}
  end

  def self.create locale, key, value
    I18n.backend.store_translations(locale, { key => value }, :escape => false)
  end
end