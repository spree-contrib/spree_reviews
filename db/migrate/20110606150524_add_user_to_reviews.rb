class AddUserToReviews < ActiveRecord::Migration[5.0]
  def self.up
    add_column :reviews, :user_id, :integer, null: true
  end

  def self.down
    remove_column :reviews, :user_id
  end
end
