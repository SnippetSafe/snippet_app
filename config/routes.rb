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

  resources :snippets, only: %i(index new show create edit update destroy) do
    get :current_folder, on: :member

    # Popover
    get :popover, on: :member

    # Filing Snippets
    post :file, on: :member
    delete :unfile, on: :member
    
    # Alerts
    get :delete_alert, on: :member
    get :unfile_alert, on: :member

    # Modals
    get :new_snippet_modal, on: :collection
    get :move_modal, on: :member
    get :edit_modal, on: :member

    resources :comments, only: :create
  end

  resources :comments, only: %i(create destroy) do
    # Popover
    get :popover, on: :member

    # Alerts
    get :delete_alert, on: :member
  end

  resources :users, only: :show do
    put :modify, on: :collection
    post :follow, on: :member
    post :unfollow, on: :member
    get :hovercard, on: :member

    # Modals
    get :edit_avatar_modal, on: :collection
    
    resources :snippets, only: :index
  end

  namespace :users do
    namespace :modals do
      get :sign_in_sign_up
      get :sign_in
      get :sign_up
    end
  end

  resources :likes, only: :create

  resources :folders, only: %i(index show new edit create update destroy) do
    # Popover
    get :popover, on: :member

    # Alerts
    get :delete_alert, on: :member

    # Modals
    get :new_folder_modal, on: :collection

    put :file_snippet, on: :collection
    put :unfile_snippet, on: :collection
  end
end
