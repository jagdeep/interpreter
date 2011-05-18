class Interpreter::Base
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  extend ActiveModel::Translation
  include ActiveModel::Validations
  include ActiveModel::AttributeMethods

  class_attribute :_attributes
  self._attributes = []

  attribute_method_suffix '?'

  def self.attributes(*names)
    attr_accessor *names
    define_attribute_methods names
    self._attributes += names
  end

  def attributes
    self._attributes.inject({}) do |hash, attr|
      hash[attr.to_s] = send(attr)
      hash
    end
  end

  def persisted?
    if id?
      Interpreter.backend.get(id).nil? ? false : true
    else
      false
    end
  end

  def id
    locale + '.' + key
  end

  def id?
    locale? and key?
  end

  def save
    if self.valid?
      Interpreter.backend.set("#{locale}.#{key}", value.to_json)
    else
      return false
    end
  end

  def ==(other)
    self.locale == other.locale and self.key == other.key and self.value == other.value
  end

  def self.all
    collection = []
    Interpreter.backend.keys.each do |k|
      obj = find_by_key(k)
      if obj and obj.valid?# and obj.child_keys.empty?
        collection << obj
      end
    end
    collection.sort{|a, b| a.key <=> b.key}
  end

  def self.find_all_by_key key
    result = {}
    Interpreter.backend.keys("*.#{key}").map{|k| find_by_key(k)}.compact.each do |t|
      result[t.locale] = t.value
    end
    return result
  end

  def self.find_by_key full_key
    arr = full_key.split('.')
    locale = arr.shift
    key = arr.join('.')
    obj = self.new
    obj.locale = locale
    obj.key = key
    obj.value = ActiveSupport::JSON.decode(Interpreter.backend.get(full_key))
    obj.valid? ? obj : nil
  end

  def self.find_like_key str
    Interpreter.backend.keys("*#{str}*").map{|k| find_by_key(k)}.compact.sort{|a, b| a.locale <=> b.locale}
  end

  def child_keys
    Interpreter.backend.keys("#{id}.*")
  end

  def self.destroy key
    Interpreter.backend.keys("*.#{key}").sum{|k| Interpreter.backend.del(k)}
  end

  def self.categories
    Interpreter.backend.keys.map{|k| k.split('.')[1]}.uniq
  end

  def self.available_locales
    Interpreter.locales
  end

  protected

  def attribute?(attribute)
    send(attribute).present?
  end
end
