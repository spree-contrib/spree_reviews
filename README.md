Reviews
=======

Spree extension to provide straightforward review/rating facility, made even more straightforward!

Have updated and removed a lot of stuff that isn't needed for a specific implementation.


Installation
------------

To use the last stable gem release of spree_reviews, add the following to your Gemfile:

    gem 'spree_reviews'
    
If you'd rather install the latest version with fixes and improvements that have not yet been published to RubyGems, install from git:

    gem 'spree_reviews', :git => 'git://github.com/markturner/spree_reviews.git'

Now bundle up with:

    bundle
    
Next, run the rake task that copies the necessary migrations and assets to your project:

    rails g spree_reviews:install
    
And finish with a migrate:

    rake db:migrate
    
Now you should be able to boot up your server with:

    rails s
    
    
That's all!