module Spree
  module Admin
    class ReviewSettingsController < ResourceController
      def update
        settings = Spree::ReviewSetting.new

        preferences = params&.key?(:preferences) ? params.delete(:preferences) : params
        preferences.each do |name, value|
          next unless settings.has_preference? name
          settings[name] = value
        end
        flash[:success] = Spree.t(:successfully_updated, resource: Spree.t(:review_settings, scope: :spree_reviews))
        redirect_to edit_admin_review_settings_path
      end
    end
  end
end
