class Admin::FeedbackReviewsController <  Admin::BaseController
  resource_controller
  belongs_to :review

  create.response do |wants|
    wants.html { redirect_to collection_path }
  end

  update.response do |wants|
    wants.html { redirect_to collection_path }
  end

  destroy.response do |wants|
    wants.html { redirect_to collection_path }
  end
end
