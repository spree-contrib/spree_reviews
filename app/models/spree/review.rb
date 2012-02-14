class Spree::Review < ActiveRecord::Base
  belongs_to :product
  belongs_to :user
  has_many   :feedback_reviews

  validates_presence_of     :name, :review
  validates_numericality_of :rating, :only_integer => true

  default_scope order("spree_reviews.created_at DESC")

  attr_protected :user_id, :product_id, :ip_address

  class << self
    def approved
      where("approved = ?", true)
    end

    def not_approved
      where("approved = ?", false)
    end

    def approval_filter
      where(["(? = ?) or (approved = ?)", Spree::Reviews::Config[:include_unapproved_reviews], true, true])
    end

    def oldest_first
      order("created_at asc")
    end

    def preview
      limit(Spree::Reviews::Config[:preview_size]).oldest_first
    end
  end

  def feedback_stars
    return 0 if feedback_reviews.count <= 0
    ((feedback_reviews.sum(:rating) / feedback_reviews.count) + 0.5).floor
  end
end
