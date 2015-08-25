Rails.application.routes.draw do
  devise_for :users, :controllers => {:registrations => "registrations"},
    :skip => [:registrations]
  as :user do
    get "users/edit" => "devise/registrations#edit",
      :as => "edit_user_registration"
    put "users" => "devise/registrations#update", :as => "user_registration"
  end

  root "static_pages#home"
  get "help" => "static_pages#help"
  get "about" => "static_pages#about"

  namespace :supervisor do
    root "courses#index"
    resources :courses do
      collection {get :search, to: "courses#index"}
      resource :assign_trainees, only: [:edit, :update]
    end
    resources :users, except: [:show, :edit, :update] do
      collection {get :search, to: "users#index"}
    end
  end

  devise_scope :user do
    authenticated :user do
      root "static_pages#home", as: :authenticated_root
    end
    unauthenticated do
      root "static_pages#home", as: :unauthenticated_root
    end
  end

  resources :users

end
