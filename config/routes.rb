Rails.application.routes.draw do
  get 'profiles/show'


  as :user do
    get 'signup', to: 'devise/registrations#new', as: :signup
    get 'signin', to: 'devise/sessions#new', as: :signin
    get 'signout', to: 'devise/sessions#destroy', as: :logout
  end

  devise_for :users, skip: [:sessions]

  as :user do
    get 'signin', to: 'devise/sessions#new', as: :new_user_session
    post "signin", to: 'devise/sessions#create', as: :user_session
    delete 'signout', to: 'devise/sessions#destroy', as: :destroy_user_session
  end

  resources :user_friendships do
    member do
      put :accept
    end
  end


  resources :statuses
  get 'feed', to: 'statuses#index', as: :feed
  root :to => 'statuses#index'

  get '/:id', to: 'profiles#show', as: 'profile'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
