module SpreeReviews
  module Generators
    class InstallGenerator < Rails::Generators::Base

      class_option :auto_run_migrations, :type => :boolean, :default => false

      def add_devise_config
        # Silences Devise warnings
        create_file "config/initializers/devise.rb", %Q{
          Devise.secret_key = "fake" * 10
        }
      end

      def add_javascripts 
        append_file "vendor/assets/javascripts/spree/frontend/all.js", "//= require spree/frontend\n"
        append_file "vendor/assets/javascripts/spree/backend/all.js", "//= require spree/backend\n"
      end

      def add_stylesheets
        inject_into_file "vendor/assets/stylesheets/spree/frontend/all.css", " *= require spree/frontend/spree_reviews\n", :before => /\*\//, :verbose => true
      end

      def add_migrations
        run 'bundle exec rake railties:install:migrations FROM=spree_reviews'
      end

      def run_migrations
        run_migrations = options[:auto_run_migrations] || ['', 'y', 'Y'].include?(ask 'Would you like to run the migrations now? [Y/n]')
        if run_migrations
          run 'bundle exec rake db:migrate'
        else
          puts 'Skipping rake db:migrate, don\'t forget to run it!'
        end
      end
    end
  end
end
