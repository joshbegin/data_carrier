DataCarrier::Application.routes.draw do
  resources :contacts

  resources :feeds

  resources :feed_contacts

  resources :companies

  resources :parent_companies

  root :to => "home#index"
  devise_for :users, :controllers => {:registrations => "registrations"}
  resources :users
end