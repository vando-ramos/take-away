Rails.application.routes.draw do
  devise_for :users

  root 'home#index'

  resources :establishments do
    resources :operating_hours
  end

  resources :dishes, only: %i[index show new create edit update] do
    post 'active', on: :member
    post 'inactive', on: :member

    resources :dish_options, only: %i[index new create edit update]
  end

  resources :drinks, only: %i[index show new create edit update] do
    post 'active', on: :member
    post 'inactive', on: :member

    resources :drink_options, only: %i[index new create edit update]
  end

  resources :search, only: [:index]

  resources :price_history, only: %i[index]

  resources :tags, only: %i[index new create edit update destroy]

  resources :menus

  resources :orders do
    resources :order_dishes, only: %i[new create]
    resources :order_drinks, only: %i[new create]

    post 'in_preparation', on: :member
    post 'canceled', on: :member
    post 'ready', on: :member
    post 'delivered', on: :member
  end

  resources :pre_registrations

  namespace :api do
    namespace :v1 do
      resources :establishments, param: :code, only: [] do
        resources :orders, param: :code, only: %i[index show] do
          member do
            patch :in_preparation
            patch :canceled
            patch :ready
          end
        end
      end
    end
  end
end
