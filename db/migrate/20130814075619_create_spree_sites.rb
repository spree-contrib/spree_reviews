class CreateSpreeSites < ActiveRecord::Migration
  def change
    create_table :spree_sites do |t|
      t.decimal :avg_rating
      t.integer :reviews_count

      t.timestamps
    end

    Spree::Site.create
  end
end
