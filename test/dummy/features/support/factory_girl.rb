require 'factory_girl'
# require File.dirname(__FILE__) + '/../../spec/factories'
Dir[Rails.root + "features/factories/*.rb"].each { |file| require file }