ENV["RAILS_ENV"] = "test"
require 'simplecov' if ENV['COVERAGE']
require File.expand_path("../dummy/config/environment.rb",  __FILE__)
require 'rspec/rails'
require 'ffaker'
require 'database_cleaner'

require 'capybara'
require 'capybara/rspec'
require 'capybara/rails'

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

  config.before do
    if example.metadata[:js]
      DatabaseCleaner.strategy = :truncation
    else
      DatabaseCleaner.strategy = :transaction
    end
    DatabaseCleaner.start
  end

  config.after do
    DatabaseCleaner.clean
  end

  require 'capybara/poltergeist'
  Capybara.javascript_driver = :poltergeist
end
