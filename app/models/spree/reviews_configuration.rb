class Spree::ReviewsConfiguration < Spree::Preferences::Configuration
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
  
  # if the user is not logged in, show the 'write your own review' link anyway
  preference :always_show_create, :boolean, :default => true
end
