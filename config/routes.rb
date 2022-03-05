Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations',
                                    sessions: 'users/sessions' }
  devise_scope :user do
    get '/users', to: redirect("/users/sign_up")
    get '/users/sign_out' => 'devise/sessions#destroy'
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end
  get 'restaurants/top'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root :to => 'restaurants#top'
  get 'restaurants/search' => 'restaurants#search'
  resources :restaurants do
    resources :favorites, only: [:create, :destroy]
  end
  get 'users/profile' => 'users#show'
  resources :users, only: [:show] do
    get :favorites, on: :collection
  end
  resources :reviews, only: [:index, :create, :new, :destroy]
end
