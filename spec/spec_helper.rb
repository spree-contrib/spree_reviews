# Configure Rails Environment
ENV["RAILS_ENV"] = "test"
require File.expand_path("../dummy/config/environment.rb",  __FILE__)
require 'rspec/rails'
require 'ffaker'

require 'capybara'
require 'capybara/rspec'
require 'capybara/rails'
require 'capybara/webkit'

Dir[File.join(File.dirname(__FILE__), "support/**/*.rb")].each {|f| require f }

require 'spree/testing_support/factories'
require 'spree/testing_support/controller_requests'
require 'spree/testing_support/authorization_helpers'
require 'spree/testing_support/url_helpers'

Dir[File.join(File.dirname(__FILE__), "factories/*.rb")].each {|f| require f }

RSpec.configure do |config|
  config.include Spree::TestingSupport::ControllerRequests
  config.include FactoryGirl::Syntax::Methods
  config.include Spree::TestingSupport::UrlHelpers
  config.extend Spree::TestingSupport::AuthorizationHelpers::Request, :type => :feature
  config.use_transactional_fixtures = false

  Capybara.javascript_driver = :webkit
end
