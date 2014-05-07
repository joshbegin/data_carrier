DataCarrier::Application.routes.draw do
  resources :companies

  resources :parent_companies

  root :to => "home#index"
  devise_for :users, :controllers => {:registrations => "registrations"}
  resources :users
end