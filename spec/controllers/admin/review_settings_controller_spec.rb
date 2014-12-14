RSpec.describe Spree::Admin::ReviewSettingsController, type: :controller do
  stub_authorization!

  before do
    reset_spree_preferences
    user = create(:admin_user)
    allow(controller).to receive(:try_spree_current_user).and_return(user)
  end

  context '#update' do
    it 'redirects to review settings page' do
      spree_put :update, preferences: { preview_size: 4 }
      expect(response).to redirect_to spree.edit_admin_review_settings_path
    end

    context 'For parameters:
            include_unapproved_reviews: true
            preview_size: 4,
            show_email: true,
            feedback_rating: true,
            require_login: false,
            track_locale: true
            show_identifier: true' do

      it 'sets preferred_include_unapproved_reviews to false' do
        spree_put :update, preferences: { include_unapproved_reviews: true }
        expect(Spree::Reviews::Config.preferred_include_unapproved_reviews).to be(true)
      end

      it 'sets preferred_preview_size to 4' do
        spree_put :update, preferences: { preview_size: 4 }
        expect(Spree::Reviews::Config.preferred_preview_size).to be(4)
      end

      it 'sets preferred_show_email to false' do
        spree_put :update, preferences: { show_email: true }
        expect(Spree::Reviews::Config.preferred_show_email).to be(true)
      end

      it 'sets preferred_feedback_rating to false' do
        spree_put :update, preferences: { feedback_rating: true }
        expect(Spree::Reviews::Config.preferred_feedback_rating).to be(true)
      end

      it 'sets preferred_require_login to true' do
        spree_put :update, preferences: { require_login: false }
        expect(Spree::Reviews::Config.preferred_require_login).to be(false)
      end

      it 'sets preferred_track_locale to true' do
        spree_put :update, preferences: { track_locale: true }
        expect(Spree::Reviews::Config.preferred_track_locale).to be(true)
      end

      it 'sets preferred_show_identifier to false' do
        spree_put :update, preferences: { show_identifier: true }
        expect(Spree::Reviews::Config.preferred_show_identifier).to be(true)
      end
    end
  end

  context '#edit' do
    it 'renders the edit template' do
      spree_get :edit
      expect(response).to render_template(:edit)
    end
  end
end
