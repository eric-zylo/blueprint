ENV["RAILS_ENV"] ||= "test"
require File.expand_path('../../config/environment', __FILE__)
require "rails/test_help"
require 'factory_bot_rails'
require 'mocha/minitest'

class ActiveSupport::TestCase
  parallelize(workers: 12)

  include FactoryBot::Syntax::Methods
end

class ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  Rails.application.reload_routes_unless_loaded
end
