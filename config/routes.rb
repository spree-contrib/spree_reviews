

map.namespace :admin do |admin|
  admin.resources :reviews
end

map.resources :products do |product|
  product.resources :reviews # , :member => {:submit => :post}
end


