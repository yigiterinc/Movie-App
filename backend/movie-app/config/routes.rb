Rails.application.routes.draw do
  resources :users
  resources :movies
  resources :genres
  resources :stars
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  #
  post '/user/authenticate', to: 'authenticate#authenticate'

  get '/user/stars', to: 'users#stars'
  get '/user/movies', to: 'users#movies'
  get '/user/genres', to: 'users#genres'
  get '/user/recommendations', to: 'users#recommendations'

  post '/user/follow', to: 'users#follow'
  post '/user/unfollow', to: 'users#unfollow'

  get '/genre/find_genre_movies', to: 'genres#find_genre_movies'
  get '/star/find_movies', to: 'stars#find_movies'

  get '/tmdb/find', to: 'tmdb#find'
  get '/tmdb/detail', to: 'tmdb#detail'
  get '/tmdb/search', to: 'tmdb#search'
  get '/tmdb/in_theatre', to: 'tmdb#in_theatre'
  get '/tmdb/popular', to: 'tmdb#popular'

  post '/tmdb/save_popular_movies', to: 'tmdb#save_popular_movies'
  post '/tmdb/save_genres', to: 'tmdb#save_genres'
  post '/tmdb/save_stars', to: 'tmdb#save_stars'

  post 'password/forgot', to: 'passwords#forgot'
  post 'password/reset', to: 'passwords#reset'
end
