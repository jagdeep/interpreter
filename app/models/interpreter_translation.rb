class InterpreterTranslation < Interpreter::Base
  attributes :locale, :key, :value

  validates :locale, :presence => true
  validates :key, :presence => true
  validates :value, :presence => true

  def human_name
    "Translation"
  end
end