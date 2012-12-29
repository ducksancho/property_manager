PropertyManager::Application.routes.draw do
  resources :users, :only => [:new, :create, :edit, :update]
  
  match '/design', :to => 'pages#design', :as => 'design'  
  match '/dashboard', :to => 'pages#dashboard', :as => 'dashboard'  
  match '/signup', :to => 'users#new'
  root :to => "pages#test"
end
