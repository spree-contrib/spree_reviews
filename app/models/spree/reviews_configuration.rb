class Spree::ReviewsConfiguration < Spree::Preferences::Configuration
  def self.boolean_preferences
    %w(include_unapproved_reviews feedback_rating show_email require_login track_locale)
  end

  # include non-approved reviews in (public) listings
  preference :include_unapproved_reviews, :boolean, :default => false

  # control how many reviews are shown in summaries etc.
  preference :preview_size, :integer, :default => 3

  # show a reviewer's email address
  preference :show_email, :boolean, :default => false

  # show helpfullness rating form elements
  preference :feedback_rating, :boolean, :default => false

  # require login to post reviews
  preference :require_login, :boolean, :default => true

  # whether to keep track of the reviewer's locale
  preference :track_locale, :boolean, :default => false
end
