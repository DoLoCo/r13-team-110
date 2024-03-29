CollabBrainstorming::Application.routes.draw do
  devise_for :users

  namespace :api do
    resources :users, only: [] do
      collection do
        get 'search'
      end
    end

    resources :themes, only: [:show, :create, :update] do
      resources :theme_members, path: '/members', only: [:index, :create, :destroy]
      resources :groups, only: [:index, :create, :update, :destroy]
      resources :ideas, only: [:index, :create, :update, :destroy] do
        resources :comments, only: [:index, :create, :destroy]
      end
    end
  end

  resources :themes, only: [:index, :show, :new, :create]

  get 'guest', to: 'welcome#guest'

  root to: 'welcome#index'
end
