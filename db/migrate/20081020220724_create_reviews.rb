class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.string :body
      t.integer :rating
      t.string :state, default: 'published'
      t.references :commenter
      t.references :product

      t.timestamps
    end

    add_index :reviews, :commenter_id
    add_index :reviews, :product_id
  end
end
