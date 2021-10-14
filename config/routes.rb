Rails.application.routes.draw do
  get 'restaurant/top'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root :to => 'restaurant#top'
end
