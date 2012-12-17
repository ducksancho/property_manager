PropertyManager::Application.routes.draw do
  match '/design', :to => 'pages#design', :as => 'design'  
  match '/dashboard', :to => 'pages#dashboard', :as => 'dashboard'  
  root :to => "pages#design"
end
