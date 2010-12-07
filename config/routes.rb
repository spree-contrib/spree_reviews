Rails.application.routes.draw do
  namespace :admin do
    resources :reviews
    resource :review_settings
  end

  resources :products do
    resources :reviews do
      collection do
        get :terms
        get "submissionguidelines"
      end
    end
  end
end
