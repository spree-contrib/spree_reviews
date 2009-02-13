# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

class ReviewsExtension < Spree::Extension
  version "1.0"
  description "Support for reviews and ratings within Spree"
  url "git://github.com/paulcc/spree-reviews.git"

  define_routes do |map|
    map.namespace :admin do |admin|
      admin.resources :reviews
    end  
  end
  
  def activate
    # admin.tabs.add "Reviews", "/admin/reviews", :after => "Layouts", :visibility => [:all]

    Admin::ConfigurationsController.class_eval do
      before_filter :add_review_links, :only => :index

      def add_review_links
        @extension_links << {:link => admin_reviews_path, :link_text => t('review_management'), :description => t('review_management_description')}
      end
    end

    # Add access to reviews/ratings to the product model
    Product.class_eval do
      has_one :rating
      has_many :reviews

      def get_stars
        if rating.nil? 
          [0,0]
        else
          [rating.get_stars, rating.count]
        end
      end
    end
  end
  
  def deactivate
    # admin.tabs.remove "Reviews"
  end
  
end
