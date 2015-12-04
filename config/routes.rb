Rails.application.routes.draw do
  root 'pages#home'

  devise_for :users,
              path: '',
              path_names: { sign_in: 'login', sign_out: 'logout', edit: 'profile' },
              controllers: { omniauth_callbacks: :omniauth_callbacks, registrations: 'registrations' }
  resources :users, only: :show
  resources :rooms do
    resource :reservations, only: :create
  end
  get '/preload', to: 'reservations#preload'
  get '/preview', to: 'reservations#preview'
  get '/reservations', to: 'reservations#index'

  resources :photos
end
