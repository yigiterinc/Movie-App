Rails.application.routes.draw do
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  #
  post '/user/authenticate', to: 'authenticate#authenticate'
end
