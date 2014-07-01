Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_reviews'
  s.version     = '1.0.0'
  s.summary     = 'Basic review and ratings facility for Spree'
  s.authors 	  = ['Paul Callaghan']
  s.description = s.summary
  s.required_ruby_version = '>= 1.9.3'

  s.homepage     = 'https://github.com/spree/spree-reviews/'

  s.files        = `git ls-files`.split("\n")
  s.test_files   = `git ls-files -- spec/*`.split("\n")
  s.require_path = 'lib'
  s.requirements << 'none'

  s.add_dependency 'spree_core', '~> 2.3.0'

  s.add_development_dependency 'ffaker'
  s.add_development_dependency 'capybara', '~> 2.2.1'
  s.add_development_dependency 'database_cleaner', '1.2.0'
  s.add_development_dependency 'poltergeist', '1.5.0'
  s.add_development_dependency 'rspec-rails', '~> 2.14'
  s.add_development_dependency 'factory_girl', '~> 4.4'
  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'simplecov', '~> 0.7.1'
  s.add_development_dependency 'coffee-rails', '~> 4.0.0'
  s.add_development_dependency 'sass-rails', '~> 4.0.0'
  s.add_development_dependency 'guard-rspec'
  s.add_development_dependency 'pry'
end
