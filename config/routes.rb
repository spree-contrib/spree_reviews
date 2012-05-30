Spree::Core::Engine.routes.append do
  namespace :admin do
    resources :reviews, only: [:index, :destroy] do
      put :toggle_published
    end
  end

  resources :products do
    resources :reviews, only: :create
  end
end
