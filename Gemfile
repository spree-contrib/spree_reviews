source "https://rubygems.org"
gemspec

group :test do
  if RUBY_PLATFORM.downcase.include? "darwin"
    gem 'guard-rspec'
    gem 'rb-fsevent'
    gem 'growl'
  end
end

gem 'spree', github: 'spree/spree', branch: '2-0-stable'
gem 'spree_auth_devise', github: 'spree/spree_auth_devise', branch: '2-0-stable'
