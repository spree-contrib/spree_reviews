Deface::Override.new(:virtual_path => "spree/layouts/admin",
                     :name => "spree_reviews_admin_tab",
                     :insert_bottom => "[data-hook='admin_tabs']",
                     :text => "<%= tab(:reviews, icon: 'icon-star', route: 'admin_reviews') %>",
                     :disabled => false)
