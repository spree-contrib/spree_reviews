# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

class ReviewsExtension < Spree::Extension
  version "1.0"
  description "Describe your extension here"
  url "http://yourwebsite.com/reviews"

  # define_routes do |map|
  #   map.namespace :admin do |admin|
  #     admin.resources :whatever
  #   end  
  # end
  
  def activate
    # admin.tabs.add "Reviews", "/admin/reviews", :after => "Layouts", :visibility => [:all]

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
