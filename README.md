# Reviews

[![Build Status](https://travis-ci.org/spree-contrib/spree_reviews.svg?branch=2-1-stable)](https://travis-ci.org/spree-contrib/spree_reviews)
[![Code Climate](https://codeclimate.com/github/spree-contrib/spree_reviews/badges/gpa.svg)](https://codeclimate.com/github/spree-contrib/spree_reviews)

Straightforward review/rating functionality.

---

## Installation

Add the following to your `Gemfile` to install from git:
```ruby
gem 'spree_reviews', github: 'spree-contrib/spree_reviews', branch: '2-1-stable'
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

---

## Usage

Action "submit" in "reviews" controller - goes to review entry form

Users must be logged in to submit a review

Three partials:
 - `app/views/spree/products/_rating.html.erb` -- display number of stars
 - `app/views/spree/products/_shortrating.html.erb` -- shorter version of above
 - `app/views/spree/products/_review.html.erb` -- display a single review

Administrator can edit and/or approve and/or delete reviews.

## Implementation

Reviews table is quite obvious - and note the "approved" flag which is for the
administrator to update.

Ratings table holds current fractional value - avoids frequent recalc...

---

## Discussion

Some points which might need modification in future:

 - I don't track the actual user on a review (just their "screen name" at the
   time), but we may want to use this information to avoid duplicate reviews
   etc. See https://github.com/spree/spree_reviews/issues/18
 - Rating votes are tied to a review, to avoid spam. However: ratings are
   accepted whether or not the review is accepted. Perhaps they should only
   be counted when the review is approved.

---

## Contributing

See corresponding [contributing guidelines][1].

---

Copyright (c) 2009-2014 [Spree Commerce][2] and [contributors][3], released under the [New BSD License][4]

[1]: https://github.com/spree-contrib/spree_reviews/blob/master/CONTRIBUTING.md
[2]: https://github.com/spree
[3]: https://github.com/spree-contrib/spree_reviews/graphs/contributors
[4]: https://github.com/spree-contrib/spree_reviews/blob/master/LICENSE.md
