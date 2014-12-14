RSpec.feature 'Admin Settings for Reviews', :js do
  stub_authorization!

  background do
    visit spree.edit_admin_review_settings_path
  end

  scenario 'update' do
    expect(page).to have_text 'Size of the review snippets'

    check 'include_unapproved_reviews'
    check 'feedback_rating'
    check 'show_email'
    check 'require_login'
    check 'track_locale'
    check 'show_identifier'
    fill_in 'preview_size', with: '5'
    click_button 'Update'

    expect(page).to have_text 'successfully updated!'

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
