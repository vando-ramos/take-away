Rails.application.routes.draw do
  devise_for :users

  root 'home#index'

  resources :establishments do
    resources :operating_hours
    resources :tags
  end

  resources :dishes do
    post 'active', on: :member
    post 'inactive', on: :member

    resources :dish_options, only: %i[new create edit update]

    resources :dish_price_history, only: %i[index]
  end

  resources :drinks do
    post 'active', on: :member
    post 'inactive', on: :member

    resources :drink_options, only: %i[new create edit update]

    resources :drink_price_history, only: %i[index]
  end

  resources :search, only: [:index]

  resources :menus

  resources :orders do
    resources :order_dishes, only: %i[new create]
    resources :order_drinks, only: %i[new create]

    post 'in_preparation', on: :member
    post 'canceled', on: :member
    post 'ready', on: :member
    post 'delivered', on: :member
  end
end
