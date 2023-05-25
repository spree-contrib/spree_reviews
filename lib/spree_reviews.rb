require 'spree_core'
require 'spree_extension'
require 'spree_backend'
require 'spree_reviews/engine'
require 'spree_reviews/version'
require 'deface'
require 'sass/rails'

module Spree
  module Reviews
    module_function

    def config(*)
      yield(Spree::Reviews::Config)
    end
  end
end
