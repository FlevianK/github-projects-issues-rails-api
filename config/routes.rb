Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post "projects", to: "projects#create"
  patch "projects/:id", to: "projects#update"
  post "issues", to: "issues#create"
end
