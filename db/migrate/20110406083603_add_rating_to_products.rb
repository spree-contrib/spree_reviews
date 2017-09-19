class AddRatingToProducts < SpreeExtension::Migration[4.2]
  def self.up
    if table_exists?('products')
      add_column :products, :avg_rating, :decimal, default: 0.0, null: false, precision: 7, scale: 5
      add_column :products, :reviews_count, :integer, default: 0, null: false
    elsif table_exists?('spree_products')
      add_column :spree_products, :avg_rating, :decimal, default: 0.0, null: false, precision: 7, scale: 5
      add_column :spree_products, :reviews_count, :integer, default: 0, null: false
    end
  end

  def self.down
    if table_exists?('products')
      remove_column :products, :reviews_count
      remove_column :products, :avg_rating
    elsif table_exists?('spree_products')
      remove_column :spree_products, :reviews_count
      remove_column :spree_products, :avg_rating
    end
  end
end
