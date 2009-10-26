

map.namespace :admin do |admin|
  admin.resources :reviews
  admin.resource :review_settings
end

map.resources :products do |product|
  product.resources :reviews # , :member => {:submit => :post}
end

