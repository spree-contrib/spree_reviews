Deface::Override.new(:virtual_path => "spree/admin/shared/_tabs",
                    :name => "reviews_admin_tab_root",
                    :insert_bottom => "code[erb-loud]:contains('tab :products')",
                    :text => ", :reviews")