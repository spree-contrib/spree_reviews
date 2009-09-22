class Review < ActiveRecord::Base
  belongs_to :product

  validates_presence_of :name, :location, :title, :review
  validates_numericality_of :rating, :only_integer => true

  named_scope :approved,     lambda {|*args| {:conditions => "approved"}}   
  named_scope :not_approved, lambda {|*args| {:conditions => "not approved"}} 
  named_scope :preview,      :limit=>3, :order=>"created_at desc"

end
