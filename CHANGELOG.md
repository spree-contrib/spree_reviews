# Changelog

### v3.0.0.beta

* Updated layout and Deface hooks to work with new Spree Bootstrap layout.
* Refactor configuration settings so it actually works without boolean hacks.
* Renamed preference `:render_show_identifier_checkbox` to `:show_identifier` and applied it to settings form so it can be changed from admin.
* Moved loose constant `NB_STARS` into settings, now reached with `SpreeReviews::Config.stars`.
* Heavy syntax refactor for Rubocop and Hound CI.
* It now only support Ruby 2.1.x, same as Spree v3.0.0.beta
