source "http://rubygems.org"
gemspec

group :test do
  if RUBY_PLATFORM.downcase.include? "darwin"
    gem 'guard-rspec'
    gem 'rb-fsevent'
    gem 'growl'
  end
end

gem 'spree_auth_devise', :git => 'git://github.com/spree/spree_auth_devise'