PropertyManager::Application.routes.draw do
  match '/design', :to => 'pages#design', :as => 'design'  
  
  root :to => "pages#design"
end
