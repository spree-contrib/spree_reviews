class ChangeReviewBodyColumnType < ActiveRecord::Migration
  def up
    change_column :reviews, :body, :text
  end

  def down
    change_column :reviews, :body, :string
  end
end
