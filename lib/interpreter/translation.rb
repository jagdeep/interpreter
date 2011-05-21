class Interpreter::Translation < Interpreter::Base
  attributes :key
  locales *Interpreter.locales

  validates :key, :presence => true

  def initialize options={}
    self.key = options[:key]
    self.class.available_locales.each do |locale|
      self.send("#{locale}=", options[locale])
    end
  end

  def persisted?
    if key?
      Interpreter.backend.keys("??.#{key}").present?
    else
      super
    end
  end

  def id
    self.key.gsub('.','-')
  end

  def save
    if self.valid?
      self.class.available_locales.each do |locale|
        value = self.send(locale)
        Interpreter.backend.set("#{locale}.#{key}", value.to_json) unless value.nil?
      end
    else
      return false
    end
  end

  def update_attributes options={}
    self.key = options[:key]
    self.class.available_locales.each do |locale|
      self.send("#{locale}=", options[locale])
    end
  end

  def ==(other)
    self.key == other.key
  end

  def self.all
    result = []
    Interpreter.backend.keys("??.*").each do |full_key|
      key, locale, value = parse_key(full_key)

      obj = result.select{|r| r.key == key }.first || self.new
      obj.send("#{locale}=", value)
      obj.send('key=', key)
      result << obj
    end
    return result.uniq
  end

  def self.find_by_key key
    collection = Interpreter.backend.keys("??.#{key}")
    if collection.present?
      obj = self.new
      obj.send('key=', key)
      collection.each do |full_key|
        key, locale, value = parse_key(full_key)
        obj.send("#{locale}=", value)
      end
      return obj
    else
      return nil
    end
  end

  def self.find_all_by_value_like str
    keys = []
    Interpreter.backend.keys.each do |full_key|
      if Interpreter.backend.get(full_key).downcase.include?(str.downcase)
        keys << parse_key(full_key).first
      end
    end
    keys.map{|k| find_by_key k}
  end

  def self.destroy key
    Interpreter.backend.keys("??.#{key}").sum{|k| Interpreter.backend.del(k)}
  end

  def self.available_locales
    Interpreter.locales
  end

  protected

  def self.parse_key full_key
    arr = full_key.split('.')
    locale = arr.shift
    key = arr.join('.')
    value = Interpreter.backend.get(full_key)
    value = ActiveSupport::JSON.decode(value) unless value.nil?
    return [key, locale, value]
  end
end
