require 'capybara'
require 'capybara/rspec'
require 'capybara/rails'
require 'capybara/poltergeist'

RSpec.configure do
  Capybara.javascript_driver = :poltergeist
end
