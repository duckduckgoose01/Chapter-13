Rails.application.routes.draw do
  get '/help', to: "static_pages#help"
  get '/about', to: "static_pages#about"
  get '/contact', to: "static_pages#contact"
  get '/signup', to: "users#new"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  resources :users
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root "static_pages#home"

  # Defines the root path route ("/")
  # root "articles#index"
end
