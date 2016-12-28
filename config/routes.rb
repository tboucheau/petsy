Rails.application.routes.draw do
  get 'sessions/new'

  get 'sessions/create'

  get 'sessions/destroy'

    root to: 'users#new'
    get '/profil', to: 'users#edit', as: :profil
    patch '/profil', to: 'users#update'
    resources :users, only: [:new, :create] do
        member do
            get 'confirm'
        end
    end

end
