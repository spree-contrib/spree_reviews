class RecalculateRatings < ActiveRecord::Migration
  def up
    Spree::Product.reset_column_information
    Spree::Product.all.each do |p|
      Spree::Product.update_counters p.id, :reviews_count => p.reviews.approved.length
      
      # recalculate_product_rating exists in the review, not the product
      if p.reviews.approved.count > 0
        p.reviews.approved.first.recalculate_product_rating
      end
    end
  end

  def down
  end
end
