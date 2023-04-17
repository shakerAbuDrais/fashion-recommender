Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api do
    namespace :v1 do
      resources :products, only: [:index]
      post 'fetch_and_save', to: 'products#fetch_and_save'
    end
  end
end
