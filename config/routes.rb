Spree::Core::Engine.routes.append do
  namespace :admin do
    resources :reviews, only: [:index, :destroy, :edit, :update] do
      member do
        get :approve
      end
      resources :feedback_reviews, only: [:index, :destroy]
    end
    resource :review_settings, only: [:edit, :update]
  end

  resources :products do
    resources :reviews, only: [:index, :new, :create] do
      collection do
        get :terms
        get "submissionguidelines"
      end
    end
  end
  post "/reviews/:review_id/feedback(.:format)" => "feedback_reviews#create"
end
