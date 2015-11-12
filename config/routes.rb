Rails.application.routes.draw do
  devise_for :users
  resources :projxes
  root 'projxes#index'
  resources :users
  get 'projxes/contributor_request'
end
