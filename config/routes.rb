Rails.application.routes.draw do
  
  resources :todo_lists do #se hara un enrutamiento de todo_lists
    resources :todo_items do # que anida a todo_items
      member do # y para todo_items quiero un metodo patch que me ejecute la accion complete
        patch :complete
      end
    end
  end

  root "todo_lists#index" #donde sera el index de la aplicacion
end
