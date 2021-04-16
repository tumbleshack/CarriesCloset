Rails.application.routes.draw do

  resources :email_settings
  get '/donations/my_donations' => 'donations#my_donations'
  resources :donations
  resources :categories
  resources :items
  get 'requests/next_status' => 'requests#next_status'
  get '/requests/my_requests' => 'requests#my_requests'
  get '/requests/popup' => 'requests#popup'
  get '/requests/volunteer' => 'requests#volunteer'
  get '/requests/:id/settle' => 'requests#settle', as: :settle_request
  get '/users/manage' => 'users#manage'
  resources :requests
  get 'public/index'
  devise_for :users, :path_prefix => 'my', controllers: { registrations: 'users/registrations', invitations: 'users/invitations' }
  resources :users
  get '/get-involved' => 'get_involved#index'
   
  resources :users

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "public#index"

end
