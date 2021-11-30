Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    get '/users', to: redirect("/users/sign_up")
  end
  get 'restaurant/top'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root :to => 'restaurant#top'
end
