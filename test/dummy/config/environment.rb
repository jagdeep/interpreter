# Load the rails application
require File.expand_path('../application', __FILE__)

TRANSLATIONS_BACKEND = Redis.new(:db => 9)

# Initialize the rails application
Dummy::Application.initialize!
