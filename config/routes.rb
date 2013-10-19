CollabBrainstorming::Application.routes.draw do
  get 'home/index'

  devise_for :users

  namespace :api do
    resources :themes, only: [:show, :create, :update] do
      resources :theme_members, path: '/members', only: [:index, :create, :destroy]
      resources :ideas, only: [:index, :create, :update, :destroy] do
        resources :comments, only: [:index, :create, :destroy]
      end
    end
  end

  resources :themes, only: [:show, :new, :create]

  root to: 'welcome#index'
end
