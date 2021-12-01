Rails.application.routes.draw do
  resources :images
  get "main" => "pages#main"
  get "upload" => "pages#upload"
end
