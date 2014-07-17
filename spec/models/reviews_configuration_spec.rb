require 'spec_helper'

describe Spree::ReviewsConfiguration do
  subject { Spree::ReviewsConfiguration.new }

  before do
    reset_spree_preferences
  end

  it 'should have the include_unapproved_reviews preference' do
    subject.should respond_to(:preferred_include_unapproved_reviews)
    subject.should respond_to(:preferred_include_unapproved_reviews=)
    subject.preferred_include_unapproved_reviews.should be false
  end

  it 'should have the preview_size preference' do
    subject.should respond_to(:preferred_preview_size)
    subject.should respond_to(:preferred_preview_size=)
    subject.preferred_preview_size.should eq(3)
  end

  it 'should have the show_email preference' do
    subject.should respond_to(:preferred_show_email)
    subject.should respond_to(:preferred_show_email=)
    subject.preferred_show_email.should be false
  end

  it 'should have the feedback_rating preference' do
    subject.should respond_to(:preferred_feedback_rating)
    subject.should respond_to(:preferred_feedback_rating=)
    subject.preferred_feedback_rating.should be false
  end

  it 'should have the require_login preference' do
    subject.should respond_to(:preferred_require_login)
    subject.should respond_to(:preferred_require_login=)
    subject.preferred_require_login.should be true
  end

  it 'should have the track_locale preference' do
    subject.should respond_to(:preferred_track_locale)
    subject.should respond_to(:preferred_track_locale=)
    subject.preferred_track_locale.should be false
  end
end
