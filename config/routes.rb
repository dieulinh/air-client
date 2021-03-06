Rails.application.routes.draw do
  root 'pages#home'

  devise_for :users,
              path: '',
              path_names: { sign_in: 'login', sign_out: 'logout', edit: 'profile' },
              controllers: { omniauth_callbacks: :omniauth_callbacks, registrations: 'registrations' }
  resources :users, only: :show
  resources :rooms do
    resource :reservations, only: :create
    resources :reviews, only: [:create, :destroy]
  end

  resources :conversations do
    resources :messages, only: [:create, :show, :index]
  end
  get '/preload', to: 'reservations#preload'
  get '/preview', to: 'reservations#preview'
  get '/reservations', to: 'reservations#index'
  get '/your_trips', to: 'reservations#your_trips'
  post '/notify', to: 'reservations#notify'
  post '/your_trips', to: 'reservations#your_trips'

  get '/search', to: 'pages#search'

  resources :photos
end
