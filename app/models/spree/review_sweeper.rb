class Spree::ReviewSweeper < ActionController::Caching::Sweeper
  observe Spree::Review

  def after_create(review)
    expire_cache_for(review)
  end

  def after_update(review)
    expire_cache_for(review)
  end

  def after_destroy(review)
    expire_cache_for(review)
  end

  private

  def expire_cache_for(review)
    review.recalculate_product_rating
  end
end
