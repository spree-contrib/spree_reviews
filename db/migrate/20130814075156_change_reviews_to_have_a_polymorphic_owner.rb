class ChangeReviewsToHaveAPolymorphicOwner < ActiveRecord::Migration
  def up
    rename_column :spree_reviews, :product_id, :reviewable_id
    add_column :spree_reviews, :reviewable_type, :string

    execute(<<-SQL)
      UPDATE spree_reviews SET reviewable_type = 'Spree::Product'
    SQL
  end

  def down
    execute(<<-SQL)
      DELETE spree_reviews WHERE reviewable_type != 'Spree::Product'
    SQL

    rename_column :spree_reviews, :reviewable_id, :product_id
  end
end
