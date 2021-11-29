source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'spree', '>= 4.3', github: 'bytebeans/spree', branch: 'my-4-3-stable'
gem 'spree_auth_devise', '~> 4.3', github: 'bytebeans/spree_auth_devise'
gem 'rails-controller-testing'

gemspec
