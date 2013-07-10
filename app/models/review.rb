class Review < ActiveRecord::Base
  belongs_to :product, class_name: Spree::Product
  belongs_to :commenter, class_name: BareNaked::Commenter
  attr_accessible :body, :rating, :state

  validates :commenter, :product, :rating, :body, presence: true
  validates :rating, numericality: { only_integer: true}
  validates :body, length: { maximum: 140 }

  scope :published, where(state: 'published').joins(:commenter).merge(BareNaked::Commenter.verified)
  scope :unpublished, where(state: 'unpublished')
  scope :in_state, lambda { |state| where(state: state) }

  def published?
    self.state == "published"
  end

  def toggle_published
    self.state = self.published? ? 'unpublished' : 'published'
    self.save
  end

  after_save :recalculate_product_rating
  def recalculate_product_rating
    reviews_count = product.reviews.reload.published.count
    if reviews_count > 0
      product.update_attributes(:avg_rating => product.reviews.published.sum(:rating).to_f / reviews_count, :reviews_count => reviews_count)
    else
      product.update_attribute(:avg_rating, 0)
    end
  end
end
