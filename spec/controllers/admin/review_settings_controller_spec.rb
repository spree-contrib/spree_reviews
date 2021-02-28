RSpec.describe Spree::Admin::ReviewSettingsController, type: :controller do
  stub_authorization!

  before do
    reset_spree_preferences
    user = create(:admin_user)
    allow(controller).to receive(:try_spree_current_user).and_return(user)
  end

  describe '#update' do
    it 'redirects to review settings page' do
      put :update, params: { preferences: { preview_size: 4 } }
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
      subject { Spree::Reviews::Config }

      it 'sets preferred_include_unapproved_reviews to false' do
        put :update, params: { preferences: { include_unapproved_reviews: true } }
        expect(subject.preferred_include_unapproved_reviews).to be(true)
      end

      it 'sets preferred_preview_size to 4' do
        put :update, params: { preferences: { preview_size: 4 } }
        expect(subject.preferred_preview_size).to be(4)
      end

      it 'sets preferred_show_email to false' do
        put :update, params: { preferences: { show_email: true } }
        expect(subject.preferred_show_email).to be(true)
      end

      it 'sets preferred_feedback_rating to false' do
        put :update, params: { preferences: { feedback_rating: true } }
        expect(subject.preferred_feedback_rating).to be(true)
      end

      it 'sets preferred_require_login to true' do
        put :update, params: { preferences: { require_login: false } }
        expect(subject.preferred_require_login).to be(false)
      end

      it 'sets preferred_track_locale to true' do
        put :update, params: { preferences: { track_locale: true } }
        expect(subject.preferred_track_locale).to be(true)
      end

      it 'sets preferred_show_identifier to false' do
        put :update, params: { preferences: { show_identifier: true } }
        expect(subject.preferred_show_identifier).to be(true)
      end
    end
  end

  describe '#edit' do
    it 'renders the edit template' do
      get :edit
      expect(response).to render_template(:edit)
    end
  end
end
