require 'sidekiq/web'
Rails.application.routes.draw do
  get '/account', to: 'accounts#show', as: :show_account
  mount Sidekiq::Web, at: '/sidekiq'
  resources :payments do
    patch '/upload_check', to: 'payments#upload_check', as: :upload_check, on: :member
    get '/approve', to: 'payments#approve', as: :approve, on: :member
    get '/deny', to: 'payments#deny', as: :deny, on: :member
    get '/pay', to: 'payments#pay', as: :pay, on: :member
  end
  post '/paymaster/confirm_invoice', to: 'payments#confirm_invoice', as: :paymaster_confirm_invoice
  post '/paymaster/notify', to: 'payments#notify', as: :paymaster_notify
  resources :messages
  resources :orders do
    get '/change_status/:status', to: 'orders#change_status', as: :change_status, on: :member
    get '/search_employee', to: 'orders#search_employee', as: :search_employee, on: :member
    get '/approve', to: 'orders#approve', as: :approve, on: :member
    get '/set_employee/:employee_id', to: 'orders#set_employee', as: :set_employee, on: :member
    get '/unset_employee/:employee_id', to: 'orders#unset_employee', as: :unset_employee, on: :member

    resources :messages do
      get '/approve', to: 'messages#approve', as: :approve, on: :member
      get '/resend', to: 'messages#resend', as: :resend, on: :member
    end
  end
  post '/orders/welcome', to: 'welcome#create_order', as: :welcome_orders

  resources :notes
  resources :events
  resources :worktypes
  resources :parts do
    patch '/upload', to: 'parts#upload', as: :upload, on: :member
  end

  resources :specialities
  devise_for :users, path_names: { sign_up: '/sign_up/:role' }

  scope '/admin' do
    resources :users do
      get '/manage', to: 'users#manage', as: :manage, on: :collection
    end
  end

  scope '/dashboard' do
    get '', to: 'dashboard#index', as: :dashboard_index
    get 'create_order', to: 'dashboard#create_order', as: :dashboard_create_order
    get 'new_orders', to: 'dashboard#new_orders', as: :dashboard_new_orders
  end
  root 'welcome#index'
end
