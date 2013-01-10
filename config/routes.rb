FlitterMysql::Application.routes.draw do
  resources :users
  resources :sessions, :only => [:new, :create, :destroy]
  resources :microposts, :only => [:create, :destroy]

  root :to => "pages#home"

  match '/contact',                 :to => 'pages#contact'
  match '/about',                   :to => 'pages#about'
  match '/flitter/user/:username',  :to => 'users#show'
  match '/users/edit/:username',    :to => 'users#edit'
  match '/signup',  				        :to => 'users#new'
  match '/signin',                  :to => 'sessions#new'
  match '/signout',                 :to => 'sessions#destroy'
end
