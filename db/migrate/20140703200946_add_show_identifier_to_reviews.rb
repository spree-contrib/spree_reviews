class AddShowIdentifierToReviews < ActiveRecord::Migration[5.0]
  def change
    add_column :spree_reviews, :show_identifier, :boolean, default: true
    add_index :spree_reviews, :show_identifier
  end
end
