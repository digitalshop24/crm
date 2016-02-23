require 'sidekiq/web'
Rails.application.routes.draw do
  match '*any' => 'application#options', :via => [:options]
  resources :seos
  get '/account', to: 'accounts#show', as: :show_account
  mount Sidekiq::Web, at: '/sidekiq'
  resources :payments do
    patch '/upload_check', to: 'payments#upload_check', as: :upload_check, on: :member
    get '/approve', to: 'payments#approve', as: :approve, on: :member
    get '/deny', to: 'payments#deny', as: :deny, on: :member
    get '/pay', to: 'payments#pay', as: :pay, on: :member
  end
  resources :payouts do
    post '/pay', to: 'payouts#pay', as: :pay, on: :collection
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
    get '/archive', to: :archive, on: :collection, as: :archive

    resources :messages do
      get '/approve', to: 'messages#approve', as: :approve, on: :member
      get '/resend', to: 'messages#resend', as: :resend, on: :member
    end
  end
  resources :galleries 
  resources :pictures
  get '/getprice', to: 'static#event'
  get '/vacancies', to: 'static#vacancy'
  get '/vacancies/edit', to: 'static#vedit'
  get '/partners', to: 'static#partners'
  get '/partners/edit', to: 'static#paedit'
  get '/pay/edit', to: 'static#pedit'
  get '/pay', to: 'static#payment'
  get '/offer', to: 'static#offer'
  get '/offer/edit', to: 'static#oedit'
  get '/contacts', to: 'static#contacts'
  get '/contacts/edit', to: 'static#cedit'

  get '/advantages', to: 'static#advantages'
  get '/conditions', to: 'static#conditions'
  get '/guarantees', to: 'static#guarantees'
  post '/orders/welcome', to: 'welcome#create_order', as: :welcome_orders
  resources :seo
  resources :feedbacks
  resources :service
  resources :steps
  resources :questions
  resources :news
  resources :revisions
  resources :materials
  resources :notes
  resources :actions
  resources :events
  resources :worktypes
  resources :parts do
    patch '/upload', to: 'parts#upload', as: :upload, on: :member
  end

  resources :specialities do
    resources :subspecialities
  end
  devise_for :users, path_names: { sign_up: '/sign_up/:role' },
  :controllers => {
    :registrations => "registrations"
  }

  scope '/admin' do
    resources :users do
      
      get '/manage', to: 'users#manage', as: :manage, on: :collection
    end
  end
  devise_scope :user do
    get 'users/add_speciality', to: "registrations#add_speciality"
    get 'users/update_specialities', to: "registrations#update_specialities"
  end

  scope '/dashboard' do
    get '', to: 'dashboard#index', as: :dashboard_index
    get 'create_order', to: 'dashboard#create_order', as: :dashboard_create_order
    get 'new_orders', to: 'dashboard#new_orders', as: :dashboard_new_orders
  end
  root 'welcome#index'
end
