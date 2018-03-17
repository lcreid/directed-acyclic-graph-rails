Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  patch "children/:id/edit", to: "children#update", as: :children
  patch "parents/:id/edit", to: "parents#update", as: :parents
  resources :people
end
