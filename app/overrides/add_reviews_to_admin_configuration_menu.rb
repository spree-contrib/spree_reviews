Deface::Override.new(:virtual_path => "spree/admin/configurations/index",
                     :name => "converted_admin_configurations_menu_286465532",
                     :insert_bottom => "[data-hook='admin_configurations_menu'], #admin_configurations_menu[data-hook]",
                     :text => "<%= configurations_menu_item(t('spree_reviews.review_settings'), admin_review_settings_path, Spree.t('spree_reviews.manage_review_settings')) %>",
                     :disabled => false)
