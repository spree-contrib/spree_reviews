Deface::Override.new(:virtual_path => "spree/layouts/admin",
                     :name => "reviews_admin_tab",
                     :insert_bottom => "[data-hook='admin_tabs']",
                     :text => "<%= tab(:reviews, :label => 'reviews') %>",
                     :disabled => false)
