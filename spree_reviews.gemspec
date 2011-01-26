Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_reviews'
  s.version     = '0.30.1'
  s.summary     = 'Basic review and ratings facility for Spree'
  #s.description = 'Add (optional) gem description here'
  s.required_ruby_version = '>= 1.8.7'

  # s.author            = 'David Heinemeier Hansson'
  # s.email             = 'david@loudthinking.com'
  # s.homepage          = 'http://www.rubyonrails.org'
  # s.rubyforge_project = 'actionmailer'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_path = 'lib'
  s.requirements << 'none'

  s.has_rdoc = true

  s.add_dependency('spree_core', '>= 0.30.1')
end
