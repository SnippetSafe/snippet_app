Rails.application.routes.draw do
  #TODO: works for development
  if Rails.env.development?
    Rails.application.routes.default_url_options[:host] = "localhost:3000"
  else
    Rails.application.routes.default_url_options[:host] = 'www.snippetsafe.com'
  end

  devise_for :users, controllers: { registrations: 'registrations', sessions: 'sessions' }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'home#index'

  namespace :modals do
    resources :users do
      get :sign_in_sign_up, on: :collection
      get :sign_in, on: :collection
      get :sign_up, on: :collection
      get :edit_avatar, on: :collection
    end

    resources :snippets, only: %i(new edit) do
      get :move, on: :member
    end

    resources :folders, only: :new
  end

  namespace :alerts do
    resources :snippets do
      get :unfile, on: :member
      get :delete, on: :member
    end

    resources :folders do
      get :delete, on: :member
    end

    resources :comments do
      get :delete, on: :member
    end
  end

  resources :snippets, only: %i(index show create edit update destroy) do
    resources :comments, only: :create

    get :current_folder, on: :member
    get :popover, on: :member
    post :file, on: :member
    delete :unfile, on: :member
  end

  resources :comments, only: %i(create destroy) do
    get :popover, on: :member
  end

  resources :users, only: %i(index show) do
    resources :snippets, only: :index
    
    put :modify, on: :collection
    post :follow, on: :member
    post :unfollow, on: :member
    get :hovercard, on: :member
  end

  resources :likes, only: :create

  resources :folders, only: %i(index show edit create update destroy) do
    get :popover, on: :member
    put :file_snippet, on: :collection
    put :unfile_snippet, on: :collection
  end
end
