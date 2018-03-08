Rails.application.routes.draw do
  devise_for :users
  root 'home#index'
  resources :contacts
  get "/home/failure" => "home#failure"
  get "/home/:importer" => "home#contacts_callback"
end
