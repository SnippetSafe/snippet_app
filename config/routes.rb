Rails.application.routes.draw do
  #TODO: works for development
  if Rails.env.development?
    Rails.application.routes.default_url_options[:host] = "localhost:3000"
  else
    Rails.application.routes.default_url_options[:host] = 'cryptic-refuge-00081.herokuapp.com'
  end

  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'home#index'

  resources :snippets, only: %i(index new show create update destroy) do
    get :search, on: :collection
    get :current_folder, on: :member
  end

  resources :comments, only: :create

  resources :users, only: :show do
    put :modify, on: :collection
    post :follow, on: :member
    post :unfollow, on: :member
  end

  resources :likes, only: :create

  resources :folders, only: %i(index show new create update destroy) do
    get :search, on: :collection
    put :file_snippet, on: :collection
    put :unfile_snippet, on: :collection
  end
end
