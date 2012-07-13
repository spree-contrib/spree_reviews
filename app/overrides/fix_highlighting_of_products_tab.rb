Deface::Override.new(:virtual_path => "spree/admin/shared/_tabs",
                    :name => "reviews_admin_tab_root",
                    :insert_bottom => "code[erb-loud]:contains('tab :products')",
                    :text => ", :reviews",
                    :original => '84f31f710e4f2e7a5d88037387a7cffbac45d280')
