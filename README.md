Reviews
=======

[![Build Status](https://secure.travis-ci.org/spree/spree_reviews.png)](http://travis-ci.org/spree/spree_reviews)

Straightforward review/rating functionality.

Installation
------------

Add the following to your `Gemfile` to install from git:
```ruby
gem 'spree_reviews', github: 'spree/spree_reviews', branch: 'master'
```
Now bundle up with:

    bundle

Next, run the rake task that copies the necessary migrations and assets to your project:

    rails g spree_reviews:install

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
 - `app/views/spree/products/_rating.html.erb` -- display number of stars
 - `app/views/spree/products/_shortrating.html.erb` -- shorter version of above
 - `app/views/spree/products/_review.html.erb` -- display a single review

Administrator can edit and/or approve and/or delete reviews.

Implementation
--------------

Reviews table is quite obvious - and note the "approved" flag which is for the
administrator to update.

Ratings table holds current fractional value - avoids frequent recalc...

Discussion
----------

Some points which might need modification in future:

 - I don't track the actual user on a review (just their "screen name" at the
   time), but we may want to use this information to avoid duplicate reviews
   etc. See https://github.com/spree/spree_reviews/issues/18
 - Rating votes are tied to a review, to avoid spam. However: ratings are
   accepted whether or not the review is accepted. Perhaps they should only
   be counted when the review is approved.

Contributing
------------

In the spirit of [free software][1], **everyone** is encouraged to help improve this project.

Here are some ways *you* can contribute:

* by using prerelease versions
* by reporting [bugs][2]
* by suggesting new features
* by writing translations
* by writing or editing documentation
* by writing specifications
* by writing code (*no patch is too small*: fix typos, add comments, clean up inconsistent whitespace)
* by refactoring code
* by resolving [issues][2]
* by reviewing patches

Starting point:

* Fork the repo
* Clone your repo
* Run `bundle install`
* Run `bundle exec rake test_app` to create the test application in `spec/test_app`
* Ensure specs pass by running `bundle exec rspec spec`
* Submit your pull request

Copyright (c) 2014 [Spree Commerce][6] and [contributors][7], released under the [New BSD License][3]

[1]: http://www.fsf.org/licensing/essays/free-sw.html
[2]: https://github.com/spree/spree_reviews/issues
[3]: https://github.com/spree/spree_reviews/blob/master/LICENSE.md
[6]: https://github.com/spree
[7]: https://github.com/spree/spree_reviews/contributors