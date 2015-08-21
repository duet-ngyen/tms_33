Rails.application.routes.draw do
  root "static_pages#home"
  get "help" => "static_pages#help"
  get "about" => "static_pages#about"

  namespace :supervisor do
    root "courses#index"
    resources :courses do
      collection {get :search, to: "courses#index"}
    end
  end
end
