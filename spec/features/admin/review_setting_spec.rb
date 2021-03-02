require 'spec_helper'

describe 'Admin Settings for Reviews', :js do
  stub_authorization!

  before do
    visit spree.edit_admin_review_settings_path
  end

  it 'update' do
    the_key_string = Spree.t(:preview_size, scope: :spree_reviews)

    if Spree.version.to_f < 4.0
      expect(page).to have_content(the_key_string.upcase)
    else
      expect(page).to have_content(the_key_string)
    end

    check 'include_unapproved_reviews'
    check 'feedback_rating'
    check 'show_email'
    check 'require_login'
    check 'track_locale'
    check 'show_identifier'
    fill_in 'preview_size', with: '5'
    fill_in 'paginate_size', with: '6'
    click_button 'Update'

    expect(page).to have_content('successfully updated!')

    setting = Spree::ReviewSetting.new

    expect(setting.preferred_include_unapproved_reviews).to be(true)
    expect(setting.preferred_feedback_rating).to be(true)
    expect(setting.preferred_show_email).to be(true)
    expect(setting.preferred_require_login).to be(true)
    expect(setting.preferred_track_locale).to be(true)
    expect(setting.preferred_show_identifier).to be(true)
    expect(setting.preferred_preview_size).to be(5)
  end
end
