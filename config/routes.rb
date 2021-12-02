Rails.application.routes.draw do
  # resources :images
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "main" => "pages#main"
  get "result" => "pages#result"
  get "tags" => "pages#tags"
  get "categories" => "pages#categories"
  get "categories" => "pages#categories"
  # get "upload" => "pages#upload"
end
