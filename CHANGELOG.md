# Changelog

### v4.0.0

* Add Zeitwerk compatablility by replacing `class_eval` with `Module.prepend` where appropriate.
* Update test suite + Use Spree Dev Tools for testing.
* Configure view files for Spree 4.1 and upwards (Bootstrap 4).
* Set Javascript to use Turbolinks for the new storefront.
* Add pagination to the reviews index page.
* Add view all reviews button to the reviews summery.
* Add reviews cancle button to the new review from.


### v3.0.0.beta

* Updated layout and Deface hooks to work with new Spree Bootstrap layout.
* Refactor configuration settings so it actually works without boolean hacks.
* Renamed preference `:render_show_identifier_checkbox` to `:show_identifier` and applied it to settings form so it can be changed from admin.
* Moved loose constant `NB_STARS` into settings, now reached with `Spree::Reviews::Config.stars`.
* Heavy syntax refactor for Rubocop and Hound CI.
* It now only support Ruby 2.1.x, same as Spree v3.0.0.beta
