Deface::Override.new(:virtual_path => "spree/admin/shared/_tabs",
                    :name => "reviews_admin_tab_root",
                    :replace_contents => "erb[loud]:contains('tab :products')",
                    :text => "tab :products, :option_types, :properties, :prototypes, :variants, :product_properties, :taxons, :reviews, :icon => 'icon-th-large'",
                    :original => '0abc74602592114216d5a53bc095823ec6759895')
