PropertyManager::Application.routes.draw do
  resources :users, :only => [:new, :create, :edit, :update]
  resources :sessions, :only => [:new, :create]
  
  get '/design', :to => 'pages#design', :as => 'design'  
  get '/dashboard', :to => 'pages#dashboard', :as => 'dashboard'  
  get '/signup', :to => 'users#new'
  get '/login', :to => 'sessions#new', :as => 'login'
  get '/logout', :to => 'sessions#destroy', :as => 'logout'
  root :to => "pages#test"
end
