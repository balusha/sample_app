Rails.application.routes.draw do
  match '/help', to: 'static_pages#help', via: 'get'
  match '/about', to: 'static_pages#about', via: 'get'
  match '/contacts', to: 'static_pages#contacts', via: 'get'
  match '/signup', to: 'users#new', via: 'get'

  root 'static_pages#home'

  resources :users


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

