Deface::Override.new(
  virtual_path: 'spree/products/show',
  name: 'add_stars_to_product_title',
  insert_after: '.product-details-title',
  partial: 'spree/shared/trigger'
)
