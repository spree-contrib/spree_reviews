class Spree::Admin::ReviewSettingsController < Spree::Admin::BaseController
  def update
    # workaround for unset checkbox behaviour
    %i[include_unapproved_reviews feedback_rating show_email require_login
       track_locale].each do |sym|

      params[:preferences][sym] = false if params[:preferences][sym].blank?
    end

    Spree::Reviews::Config.set(params[:preferences])

    respond_to do |format|
      format.html do
        redirect_to edit_admin_review_settings_path
      end
    end
  end
end
