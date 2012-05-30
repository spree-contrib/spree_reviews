class AddRatingToProducts < ActiveRecord::Migration
  def change
    add_column :spree_products, :avg_rating, :decimal, :default => 0.0, :null => false, :precision => 7, :scale => 5
    add_column :spree_products, :reviews_count, :integer, :default => 0, :null => false
  end
end
