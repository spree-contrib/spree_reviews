class CreateFeedbackReviews < SpreeExtension::Migration[4.2]
  def self.up
    create_table :feedback_reviews do |t|
      t.integer :user_id
      t.integer :review_id, null: false
      t.integer :rating,    default: 0
      t.text    :comment
      t.timestamps null: false
    end
    add_index :feedback_reviews, :review_id
    add_index :feedback_reviews, :user_id
  end

  def self.down
    drop_table :feedback_reviews
  end
end
