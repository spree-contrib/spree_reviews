class Review < ActiveRecord::Base
  belongs_to :product

  validates_presence_of :name, :location, :title, :review
  validates_numericality_of :rating, :only_integer => true

  named_scope :approved,     lambda {|*args| {:conditions => "approved = '1'"}}   
  named_scope :not_approved, lambda {|*args| {:conditions => "approved = 'f'"}} 

  named_scope :approval_filter, lambda {|*args| {:conditions => ["(? = '1') || (approved = '1')", Spree::Reviews::Config[:include_unapproved_reviews]]}} 

  named_scope :oldest_first, :order => "created_at asc"
  named_scope :preview,      :limit => Spree::Reviews::Config[:preview_size], :order=>"created_at desc"

end
