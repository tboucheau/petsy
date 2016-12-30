Rails.application.routes.draw do


    get 'pages/index'

    root to: 'pages#index'

    get '/profil', to: 'users#edit', as: :profil
    get '/animaux/:slug', to: 'posts#species', as: :species_posts
    patch '/profil', to: 'users#update'

    # Session
    get '/login', to: 'sessions#new', as: :new_session
    post '/login', to: 'sessions#create'
    delete '/logout', to: 'sessions#destroy', as: :destroy_session
    resources :posts do
        collection do
            get 'me'
        end
    end
    resources :pets do
        resource :subscriptions, only: [:create, :destroy]
    end
    resources :passwords, only: [:new, :create, :edit, :update]
    resources :users, only: [:new, :create] do
        member do
            get 'confirm'
        end
    end

end
