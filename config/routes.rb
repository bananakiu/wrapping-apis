Rails.application.routes.draw do
  root to: 'pages#main'
  # resources :images
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "main" => "pages#main", as: "main"
  # get "result" => "pages#result", as: result_path
  get "tags" => "pages#tags", as: "tags"
  get "categories" => "pages#categories", as: "categories"
  get "categorize" => "pages#categorize", as: "categorize"
  get "detect_text" => "pages#detect_text", as: "detect_text"
  # get "upload" => "pages#upload"
end
