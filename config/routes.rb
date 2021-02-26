Rails.application.routes.draw do
  get '/requests/my_requests' => 'requests#my_requests'
  resources :requests
  get 'public/index'
  devise_for :users, controllers: { invitations: 'users/invitations' }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "public#index"  
end
