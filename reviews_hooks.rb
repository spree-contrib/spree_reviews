class ReviewsHooks < Spree::ThemeSupport::HookListener
  insert_after :product_properties, 'shared/reviews'
  insert_after :inside_head do
    stylesheet_link_tag('reviews.css')
  end

  insert_after :admin_product_sub_tabs do
    tab(:reviews, :label => 'review_management')
  end
  
  insert_after :admin_configurations_menu do
    configurations_menu_item(t('reviews.review_settings'), admin_review_settings_path, t('reviews.manage_review_settings'))
  end

end
