class Review < ActiveRecord::Base
  belongs_to :product

  validates_presence_of :title, :review
  validates_numericality_of :rating, :only_integer => true

  scope :approved,  where("approved = ?", true)
  scope :not_approved, where("approved = ?", false)

  scope :approval_filter, lambda {|*args| {:conditions => ["(? = ?) or (approved = ?)", Spree::Reviews::Config[:include_unapproved_reviews], true, true ]}}

  scope :oldest_first, :order => "created_at asc"
  scope :preview,      :limit => Spree::Reviews::Config[:preview_size], :order=>"created_at desc"

end
