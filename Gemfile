source "https://rubygems.org"
gemspec

group :test do
  if RUBY_PLATFORM.downcase.include? "darwin"
    gem 'guard-rspec'
    gem 'rb-fsevent'
    gem 'growl'
  end
end

gem 'spree', :github => 'spree/spree', :branch => '1-3-stable'
gem 'spree_auth_devise', :git => 'git://github.com/spree/spree_auth_devise', :branch => '1-3-stable'
