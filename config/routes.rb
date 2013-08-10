FiveWordMovies::Application.routes.draw do
  resources :movies
  get '/welcome', to: 'static#welcome'

  root to: 'static#welcome'
end
