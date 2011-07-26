Reviews
=======

Straightforward review/rating facility

Please see TODO file


Installation
------------

To use the last stable release of spree_reviews, add the following to your Gemfile:

    gem 'spree_reviews', '0.50.1'
    
If you'd rather install from git:

    gem 'spree_reviews', :git => 'git://github.com/romul/spree_reviews.git'

Now bundle up with:

    bundle
    
Next, run the rake task that copies the necessary migrations and assets to your project:

    rake spree_reviews:install
    
And finish with a migrate:

    rake db:migrate
    
Now you should be able to boot up your server with:

    rails s  
    
    
That's all!



Usage
-----

Action "submit" in "reviews" controller - goes to review entry form

Users must be logged in to submit a review

Three partials:
 - ./app/views/products/_rating.html.erb  -- display number of stars
 - ./app/views/products/_shortrating.html.erb -- shorter version of above
 - ./app/views/products/_review.html.erb  -- display a single review

Administrator can edit and/or approve and/or delete reviews.


Implementation
--------------

reviews table is quite obvious - and note the "approved" flag which is for the
administrator to update

ratings table holds current fractional value - avoids frequent recalc...


Discussion
----------

Some points which might need modification in future:
 - I don't track the actual user on a review (just their "screen name" at the 
   time), but we may want to use this information to avoid duplicate reviews
   etc.

 - Rating votes are tied to a review, to avoid spam. However: ratings are 
   accepted whether or not the review is accepted. Perhaps they should only 
   be counted when the review is approved.
