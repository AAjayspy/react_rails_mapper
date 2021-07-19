Rails.application.routes.draw do
  root 'home#index'

  # resources :home, only: %i(index create)
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
      resources :questions
      resources :home, only: %i(create)
    end
  end
end
