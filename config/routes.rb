Rails.application.routes.draw do
  devise_for :users

  root "home#index"

  resources :establishments do
    resources :operating_hours

    resources :dishes do
      post 'active', on: :member
      post 'inactive', on: :member

      resources :dish_options, only: %i[new create edit update]

    end

    resources :drinks do
      post 'active', on: :member
      post 'inactive', on: :member

      resources :drink_options, only: %i[new create edit update]
    end

    resources :tags
  end

  resources :search, only: [:index]
end
