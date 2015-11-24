require 'sidekiq/web'
Rails.application.routes.draw do
  get '/account', to: 'accounts#show', as: :show_account
  mount Sidekiq::Web, at: '/sidekiq'
  resources :payments
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
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
