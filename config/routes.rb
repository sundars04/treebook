Rails.application.routes.draw do
  get 'profiles/show'

  devise_for :users

  devise_scope :user do
    get 'signup', to: 'devise/registrations#new', as: :signup
    get 'signin', to: 'devise/sessions#new', as: :signin    
  end

  resources :statuses
  root :to => 'statuses#index'

  get '/:id', to: 'profiles#show'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
