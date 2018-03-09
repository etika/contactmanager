Rails.application.routes.draw do
  devise_for :users
  root 'home#index'
  resources :contacts,only:[:index, :update, :edit,:destroy,:show]
  get "/home/failure" => "home#failure"
  get "/home/:importer" => "home#contacts_callback"
end
