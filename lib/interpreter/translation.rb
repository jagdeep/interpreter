class Interpreter::Translation
  attr_reader :locale, :key, :value

  def initialize locale, key, value
    @locale = locale
    @key = key
    @value = value
  end

  def ==(obj)
    self.locale == obj.locale and self.key == obj.key and self.value == obj.value
  end

  def id
    locale + '.' + key
  end

  def self.all
    collection = []
    Interpreter.backend.keys.each do |k|
      obj = find_by_key(k)
      collection << obj unless obj.has_children?
    end
    collection.sort{|a, b| a.key <=> b.key}
  end

  def self.create locale, key, value
    I18n.backend.store_translations(locale, { key => value }, :escape => false)
  end

  def self.find_all_by_key key
    Interpreter.backend.keys("*.#{key}").map{|k| find_by_key(k)}.sort{|a, b| a.locale <=> b.locale}
  end

  def self.find_by_key key
    locale = key.split('.')[0]
    k = key.gsub("#{locale}.",'')
    self.new(locale, k, Interpreter.backend.get(key))
  end

  def has_children?
    Interpreter.backend.keys("*.#{key}.*").length > 0
  end
end
