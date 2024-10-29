Rails.application.routes.draw do
  devise_for :users

  root "home#index"

  resources :establishments do
    resources :operating_hours

    resources :dishes do
      post 'active', on: :member
      post 'inactive', on: :member
    end
    
    resources :drinks do
      post 'active', on: :member
      post 'inactive', on: :member
    end
  end

  resources :search, only: [:index]
end
