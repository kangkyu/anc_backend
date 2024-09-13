Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  get 'jubo', to: "landing#index"

  get 'videos', to: "videos#index"
  resources :prayers, only: [:show, :create] do
    post 'pray', on: :member
  end

    post 'auth/firebase-auth', to: 'auth#firebase_auth'

  # Defines the root path route ("/")
  # root "posts#index"
  root "landing#index"
end
