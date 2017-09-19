class CreateReviews < SpreeExtension::Migration[4.2]
  def self.up
    create_table :reviews do |t|
      t.integer :product_id
      t.string  :name
      t.string  :location
      t.integer :rating
      t.text    :title
      t.text    :review
      t.boolean :approved, default: false
      t.timestamps null: false
    end
  end

  def self.down
    drop_table :reviews
  end
end
