class RecalculateRatings < ActiveRecord::Migration
  def up
    Spree::Product.reset_column_information
    Spree::Product.all.each do |p|
      Spree::Product.update_counters p.id, :reviews_count => p.reviews.approved.length
      p.recalculate_rating
    end
  end

  def down
  end
end
