Rails.application.routes.draw do
  devise_for :users

  root 'projxes#index'
  
  resources :projxes do
    member do
      get :requests
      get :contributor_request
      get :accept_contributor_request
      delete :remove_contributor
    end
  end
  resources :users
  
  # get 'projxes/contributor_request'
end
