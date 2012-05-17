source "http://rubygems.org"

gem 'sqlite3'

group :test do
  gem 'faker'
  # gem 'rspec-rails', '~> 2.8.1'
  # gem 'factory_girl_rails', '~> 1.7.0'
  gem 'guard-rspec'

  if RUBY_PLATFORM.downcase.include? "darwin"
    gem 'rb-fsevent'
    gem 'growl'
  end
end

gemspec