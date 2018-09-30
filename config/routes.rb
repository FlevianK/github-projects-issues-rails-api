Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post "projects", to: "projects#create"
  get "projects", to: "projects#index"
  patch "projects/:id", to: "projects#update"
  post "issues", to: "issues#create"
  patch "issues/:id", to: "issues#update"
  get "projects/:id/issues", to: "projects#get_project_issues"
end
