class CreateRatings < ActiveRecord::Migration
  def self.up
    create_table :ratings do |t|
      t.integer :product_id
      t.decimal :value
      t.integer :count
      t.timestamps
    end
  end

  def self.down
    drop_table :ratings
  end
end
