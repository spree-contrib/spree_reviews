# encoding: utf-8
ENV['LIB_NAME'] = 'spree_reviews'

require 'bundler'
Bundler::GemHelper.install_tasks
Bundler.setup

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new

require 'spree/core/testing_support/common_rake'

desc "Default Task"
task :default => [:spec]