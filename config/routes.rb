Rails.application.routes.draw do
  root :to => ""
  namespace :admin do
    resources :reviews do
      member do
        get :approve
      end
    end
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
