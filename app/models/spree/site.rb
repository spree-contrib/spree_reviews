class Spree::Site < ActiveRecord::Base
  has_many :reviews, :as => :reviewable, :dependent => :destroy
  
  attr_accessible :avg_rating, :reviews_count

  def self.instance
    Spree::Site.order('id ASC').first_or_create
  end

  def stars
    avg_rating.round
  end

  def display_reviews
    Spree::Reviews::Config[:site_reviews]
  end
end