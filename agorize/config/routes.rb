Rails.application.routes.draw do
  resources :skills do
    collection do
      get 'count_users'
    end
  end
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'users#index'
end
