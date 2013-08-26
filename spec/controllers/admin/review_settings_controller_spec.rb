require 'spec_helper'

describe Spree::Admin::ReviewSettingsController do
  stub_authorization!

  before do
    user = create(:admin_user)
    controller.stub(:try_spree_current_user => user)
  end

  context '#update' do
    it 'should update the settings when passed correct parameters' do
      preferences_params = {}
      existing_settings = Spree::ReviewsConfiguration.new
      Spree::ReviewsConfiguration.boolean_preferences.each do |p|
        preferences_params[p.to_sym] = !existing_settings.get_preference(p)
      end
      new_preview_size = 1 + SecureRandom.random_number(10)
      preferences_params[:preview_size] = new_preview_size
      spree_post :update, { preferences: preferences_params }
      response.should redirect_to(spree.edit_admin_review_settings_path)

      new_settings = Spree::ReviewsConfiguration.new
      Spree::ReviewsConfiguration.boolean_preferences.each do |p|
        new_settings.get_preference(p).should eq(preferences_params[p.to_sym])
      end
      new_settings.get_preference(:preview_size).should eq(new_preview_size)
    end
  end

  context '#edit' do
    it 'should render the edit template' do
      spree_get :edit
      response.should render_template(:edit)
    end
  end
end