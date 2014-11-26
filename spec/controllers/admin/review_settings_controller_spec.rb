RSpec.describe Spree::Admin::ReviewSettingsController, type: :controller do
  stub_authorization!

  before do
    user = create(:admin_user)
    allow(controller).to receive(:try_spree_current_user).and_return(user)
  end

  context '#update' do
    it 'redirects to edit-review-settings page' do
      spree_put :update, preferences: { preview_size: 4 }
      expect(response).to redirect_to spree.edit_admin_review_settings_path
    end

    context 'For parameters:
            preview_size: 4,
            show_email: false,
            feedback_rating: false,
            require_login: true,
            track_locale: true' do

      it 'sets preferred_preview_size to 4' do
        spree_put :update, preferences: { preview_size: 4 }
        expect(Spree::Reviews::Config.preferred_preview_size).to be(4)
      end

      it 'sets preferred_show_email to false' do
        spree_put :update, preferences: { show_email: false }
        expect(Spree::Reviews::Config.preferred_show_email).to be(false)
      end

      it 'sets preferred_feedback_rating to false' do
        spree_put :update, preferences: { feedback_rating: false }
        expect(Spree::Reviews::Config.preferred_feedback_rating).to be(false)
      end

      it 'sets preferred_require_login to true' do
        spree_put :update, preferences: { require_login: true }
        expect(Spree::Reviews::Config.preferred_require_login).to be(true)
      end

      it 'sets preferred_track_locale to true' do
        spree_put :update, preferences: { track_locale: true }
        expect(Spree::Reviews::Config.preferred_track_locale).to be(true)
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
