Rails.application.routes.draw do
  resources :categories
  resources :items
  get '/requests/my_requests' => 'requests#my_requests'
  get '/users/manage' => 'users#manage'
  resources :requests
  get 'public/index'
  devise_for :users, :path_prefix => 'my', controllers: { invitations: 'users/invitations' }
  resources :users
   
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "public#index"  
end
