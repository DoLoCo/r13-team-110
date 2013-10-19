CollabBrainstorming::Application.routes.draw do
  get "theme/new"
  get "theme/create"
  devise_for :users

  namespace :api do
    resources :themes, only: [:show, :create, :update] do
      resources :theme_members, path: '/members', only: [:index, :create, :destroy]
      resources :ideas, only: [:index, :create, :update, :destroy] do
        resources :comments, only: [:index, :create, :destroy]
      end
    end
  end

  root to: 'home#index'
end
