FiveWordMovies::Application.routes.draw do
  root to: 'static#welcome'

  resources :movies
  get '/welcome', to: 'static#welcome'
  get '/movie_search/:query', to: 'movie_search#show', format: 'json'

end
