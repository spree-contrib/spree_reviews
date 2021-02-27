# Changelog

### v4.0.0

* Rename / move `Spree::Reviews::Config.stars` to `SpreeReviews::Config.stars` in keeping with standard Spree extension configs, Please update your App as required.
* Add Zeitwerk compatablility by replacing `class_eval` with `Module.prepend` where appropriate.
* Update test suite removing outdated `spree_get` and `spree_put` & replacing with `put` `get` where required.
* Use Spree Dev Tools for Testing.



### v3.0.0.beta

* Updated layout and Deface hooks to work with new Spree Bootstrap layout.
* Refactor configuration settings so it actually works without boolean hacks.
* Renamed preference `:render_show_identifier_checkbox` to `:show_identifier` and applied it to settings form so it can be changed from admin.
* Moved loose constant `NB_STARS` into settings, now reached with `Spree::Reviews::Config.stars`.
* Heavy syntax refactor for Rubocop and Hound CI.
* It now only support Ruby 2.1.x, same as Spree v3.0.0.beta
