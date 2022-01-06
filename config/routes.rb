Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations',
                                    sessions: 'users/sessions' }
  devise_scope :user do
    get '/users', to: redirect("/users/sign_up")
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  get 'restaurants/top'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root :to => 'restaurants#top'
  resources :restaurants
  get 'users/profile' => 'users#show'
end
