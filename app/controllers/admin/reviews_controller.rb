class Admin::ReviewsController < Admin::BaseController
  require_role "admin" # You might want to remove this, and add security in the /config/easy_role_permissions.yml file
  layout 'admin'

  resource_controller

  index.before do 
    @reviews = Review.not_approved.find(:all, :order => "created_at DESC")
  end

  create.response do |wants|
    wants.html { redirect_to admin_reviews_path }
  end

  update.response do |wants|
    wants.html { redirect_to admin_reviews_path }
  end

  def approve
    r = Review.find(params[:id])
    r.approved = true
    r.save
    redirect_to admin_reviews_path
  end

end
