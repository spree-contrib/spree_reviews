Deface::Override.new(
  virtual_path: 'spree/products/show',
  name: 'what',
  insert_after: '.product-details-title',
  partial: 'spree/shared/trigger'
)
