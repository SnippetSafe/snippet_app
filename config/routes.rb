Rails.application.routes.draw do

  Rails.application.routes.default_url_options[:host] =  if Rails.env.development?
    "localhost:3000"
  elsif Rails.env.staging?
    'snippet-safe-staging.herokuapp.com'
  elsif Rails.env.production?
    'www.snippetsafe.com'
  end

  devise_for :users, controllers: {
    registrations: 'registrations',
    sessions: 'sessions',
    passwords: 'passwords',
    confirmations: 'confirmations',
    omniauth_callbacks: 'omniauth_callbacks'
  }

  devise_scope :user do
    authenticated do
      root 'home#index', as: :authenticated_root
    end

    unauthenticated do
      root 'unauthenticated/home#index', as: :unauthenticated_root
    end
  end

  get '/connect', to: 'home#connect'

  namespace :modals do
    resources :users do
      get :sign_in_sign_up, on: :collection
      get :sign_in, on: :collection
      get :sign_up, on: :collection
      get :email_confirm, on: :collection
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

  namespace :popovers do
    resources :users, only: :index
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

  resources :notifications, only: :index

  resources :users, only: %i(index show) do
    resources :snippets, only: :index
    
    put :modify, on: :collection
    post :follow, on: :member
    post :unfollow, on: :member
    get :hovercard, on: :member
  end

  resources :likes, only: :create

  resources :folders, only: %i(index show edit create update destroy) do
    resources :snippets, only: :index, controller: 'folders/snippets'

    get :popover, on: :member
    put :file_snippet, on: :collection
    put :unfile_snippet, on: :collection
  end
end
