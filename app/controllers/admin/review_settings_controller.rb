class Admin::ReviewSettingsController < Admin::BaseController
  def update
    # workaround for unset checkbox behaviour
    params[:preferences][:include_unapproved_reviews] = false if params[:preferences][:include_unapproved_reviews].blank?
    Spree::Reviews::Config.set(params[:preferences])

    respond_to do |format|
      format.html {
        redirect_to admin_review_settings_path
      }
    end
  end
end
