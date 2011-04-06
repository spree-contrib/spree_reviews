class Review < ActiveRecord::Base
  belongs_to :product, :counter_cache => true
  has_many   :feedback_reviews

  validates_presence_of :title, :review
  validates_numericality_of :rating, :only_integer => true
  default_scope order("reviews.created_at DESC")
  scope :approved,  where("approved = ?", true)
  scope :not_approved, where("approved = ?", false)

  scope :approval_filter, lambda {|*args| {:conditions => ["(? = ?) or (approved = ?)", Spree::Reviews::Config[:include_unapproved_reviews], true, true ]}}

  scope :oldest_first, :order => "created_at asc"
  scope :preview,      :limit => Spree::Reviews::Config[:preview_size], :order=>"created_at desc"

  def feedback_stars
    return 0 if feedback_reviews.count <= 0
    ((feedback_reviews.sum(:rating)/feedback_reviews.count) + 0.5).floor
  end
end
