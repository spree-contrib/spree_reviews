lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift lib unless $LOAD_PATH.include?(lib)

require 'spree_reviews/version'

Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_reviews'
  s.version     = SpreeReviews.version
  s.summary     = 'Basic review and ratings facility for Spree'
  s.description = s.summary
  s.required_ruby_version = '>= 2.5.0'

  s.author    = ['Paul Callaghan']
  s.email     = 'paulcc.two@gmail.com'
  s.homepage  = 'https://github.com/spree-contrib/spree-reviews/'
  s.license = 'BSD-3'

  s.files = `git ls-files`.split("\n").reject { |f| f.match(/^spec/) && !f.match(/^spec\/fixtures/) }
  s.require_path = 'lib'
  s.requirements << 'none'

  spree_version = '>= 4.5'
  s.add_dependency 'deface', '~> 1.0'
  s.add_dependency 'spree_api', spree_version
  s.add_dependency 'spree_backend', spree_version
  s.add_dependency 'spree_frontend', spree_version
  s.add_dependency 'spree_core', spree_version
  s.add_dependency 'spree_extension'

  s.add_development_dependency 'sass-rails'
  s.add_development_dependency 'spree_dev_tools'
  s.add_development_dependency 'pg'
end
