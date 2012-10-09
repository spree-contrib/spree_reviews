source "http://rubygems.org"

group :test do
  gem 'faker'
  gem 'rspec-rails', '~> 2.8'
  gem 'factory_girl_rails', '~> 1.7'
  gem 'sqlite3'

  if RUBY_PLATFORM.downcase.include? "darwin"
    gem 'guard-rspec'
    gem 'rb-fsevent'
    gem 'growl'
  end
end

gem 'spree', '~> 1.2.0'
gem 'spree_auth_devise', :git => 'git://github.com/spree/spree_auth_devise'

gemspec