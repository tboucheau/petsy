Rails.application.routes.draw do

    root to: 'users#new'

    get '/profil', to: 'users#edit', as: :profil
    patch '/profil', to: 'users#update'

    resources :users, only: [:new, :create] do
        member do
            get 'confirm'
        end
    end
    resources :sessions, only: [:new, :create, destroy]

end
