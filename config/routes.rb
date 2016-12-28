Rails.application.routes.draw do
    root to: 'users#new'

    resources :users, only: [:new, :create] do
        member do
            get 'confirm'
        end

end
