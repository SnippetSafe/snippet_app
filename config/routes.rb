Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: :registrations }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'home#index'

  resources :snippets, only: %i(new show create update destroy)
  resources :comments, only: :create
  resources :users, only: :show do
    post :follow, on: :member
    post :unfollow, on: :member
  end

  resources :likes, only: :create
  resources :folders, only: %i(index show new create update destroy) do
    put :file_snippet, on: :collection
    put :unfile_snippet, on: :collection
  end
end
