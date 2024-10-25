Rails.application.routes.draw do
  devise_for :users
  root "home#index"
  resources :establishments do
    resources :operating_hours
    resources :dishes
  end
end
