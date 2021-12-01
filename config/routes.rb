Rails.application.routes.draw do
  resources :images
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "main" => "pages#main"
  get "upload" => "pages#upload"
end
