source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

spree_version = '>= 4.5'
gem 'spree', spree_version
gem 'spree_auth_devise', spree_version
gem 'rails-controller-testing'


gemspec
