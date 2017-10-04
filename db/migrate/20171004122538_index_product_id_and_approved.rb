class IndexProductIdAndApproved < ActiveRecord::Migration[5.1]
  def change
    add_index :spree_reviews, [:approved, :product_id]    
  end
end
