Deface::Override.new(:virtual_path => "spree/admin/shared/_product_sub_menu",
                     :name => "reviews_admin_tab",
                     :insert_bottom => "[data-hook='admin_product_sub_tabs']",
                     :text => "<%= tab(:reviews, :label => 'review_management') %>")