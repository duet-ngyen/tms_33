Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, :controllers => {:registrations => "registrations"},
    :skip => [:registrations]
  as :user do
    get "users/edit" => "devise/registrations#edit",
      :as => "edit_user_registration"
    put "users" => "devise/registrations#update", :as => "user_registration"
  end

  devise_scope :user do
    authenticated :user do
      root "static_pages#home", as: :authenticated_root
    end
    unauthenticated do
      root "devise/sessions#new", as: :unauthenticated_root
    end
  end

  root "static_pages#home"
  get "help" => "static_pages#help"
  get "about" => "static_pages#about"

  namespace :supervisor do
    root "courses#index"
    resources :courses do
      collection {get :search, to: "courses#index"}
      resource :assign_trainees, only: [:edit, :update]
      resource :assign_subjects, only: [:edit, :update]
      resources :subjects, only: [:show]
    end
    resources :users, except: [:show, :edit, :update] do
      collection {get :search, to: "users#index"}
    end
    resources :subjects do
      collection {get :search, to: "subjects#index"}
      resources :tasks, only: [:show, :destroy]
    end
    resources :activities, only: [:index, :destroy]
  end

  resources :users
  resources :user_subjects, only: :update
  resources :courses, only: :show do
    resources :subjects, only: :show
  end
end
