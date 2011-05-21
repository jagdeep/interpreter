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

  def self.locales(*names)
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
    false
  end

  def new_record?
    !persisted?
  end

  protected

  def attribute?(attribute)
    send(attribute).present?
  end
end
