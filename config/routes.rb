CollabBrainstorming::Application.routes.draw do
  devise_for :users

  namespace :api do
    resources :themes, only: [:show, :create, :update] do
      resources :users, path: '/members', only: [:index]
      resources :theme_members, only: [:create, :destroy]
      resources :ideas, only: [:index, :create, :update, :destroy] do
        resources :comments, only: [:index, :create, :destroy]
      end
    end
  end

  root to: 'home#index'
end
