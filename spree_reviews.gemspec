lib = File.expand_path('../lib/', __FILE__)
$LOAD_PATH.unshift lib unless $LOAD_PATH.include?(lib)

require 'spree_reviews/version'

Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_reviews'
  s.version     = SpreeReviews.version
  s.summary     = 'Basic review and ratings facility for Spree'
  s.description = s.summary
  s.required_ruby_version = '>= 2.1.0'

  s.authors 	   = ['Paul Callaghan']
  s.email        = 'paulcc.two@gmail.com'
  s.homepage     = 'https://github.com/spree-contrib/spree-reviews/'
  s.license      = 'BSD-3'

  s.files        = `git ls-files`.split("\n")
  s.test_files   = `git ls-files -- spec/*`.split("\n")
  s.require_path = 'lib'
  s.requirements << 'none'

  s.add_dependency 'spree_core', '~> 3.1.0.beta'

  s.add_development_dependency 'ffaker', '>= 1.32.1'
  s.add_development_dependency 'capybara', '~> 2.4.4'
  s.add_development_dependency 'selenium-webdriver', '>= 2.44.0'
  s.add_development_dependency 'database_cleaner', '~> 1.4.0'
  s.add_development_dependency 'poltergeist', '~> 1.6.0'
  s.add_development_dependency 'rspec-rails', '~> 3.2.0'
  s.add_development_dependency 'factory_girl', '~> 4.5'
  s.add_development_dependency 'sqlite3', '>= 1.3.10'
  s.add_development_dependency 'simplecov', '~> 0.9.0'
  s.add_development_dependency 'coffee-rails', '~> 4.0.0'
  s.add_development_dependency 'sass-rails', '~> 4.0.0'
  s.add_development_dependency 'guard-rspec', '>= 4.3.1'
  s.add_development_dependency 'pry-rails', '>= 0.3.2'
  s.add_development_dependency 'rubocop', '>= 0.24.1'
end
