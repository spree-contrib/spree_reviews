require 'spree/testing_support/factories'
require 'spree/testing_support/controller_requests'
require 'spree/testing_support/authorization_helpers'
require 'spree/testing_support/preferences'
require 'spree/testing_support/url_helpers'

RSpec.configure do |config|
  config.include Spree::TestingSupport::ControllerRequests
  config.include Spree::TestingSupport::Preferences
  config.include Spree::TestingSupport::UrlHelpers
end
