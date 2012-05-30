Spree::Core::Engine.routes.append do
  namespace :admin do
    resources :reviews
  end

  resources :products do
    resources :reviews
  end
end
