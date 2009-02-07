Reviews
=======

Straightforward review facility

Please see TODO file


Usage
-----

Action "submit" in "reviews" controller - goes to review entry form

Users must be logged in to submit a review

Three partials:
 - ./app/views/products/_rating.html.erb  -- display number of stars
 - ./app/views/products/_shortrating.html.erb -- shorter version of above
 - ./app/views/products/_review.html.erb  -- display a single review

Admin interface yet to be done!


Implementation
--------------

reviews table is quite obvious - and note the "approved" flag which is for the
administrator to update

ratings table holds current fractional value - avoids frequent recalc...
