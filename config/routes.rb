WeatherViz::Application.routes.draw do

  get "alert_logs/index"

  resources :rules

  resources :alerts do
    member do
      get 'rules', to: 'alerts#rules'
      get 'logs', to: 'alerts#logs'
    end
  end

  resources :weather_reports

  resources :locations do
    member do
      get 'reports', to: 'locations#reports'
      get 'alerts', to: 'locations#alerts'
      get 'alert', to: 'locations#new_alert'
    end
  end

  resources :users do
    member do
      get 'alerts', to: 'users#alerts'
      get 'settings', to: 'users#edit'
      get 'profile', to: 'users#show'
      get 'logs', to: 'users#logs'
    end
  end

  root :to => 'static_pages#home'

  resources :sessions, only: [:login, :create, :destroy]
  get 'signup', to: 'users#new'
  get 'login', to: 'sessions#login'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  get 'logout', to: 'static_pages#home'
  get 'auth/:provider/callback', to: 'sessions#oauth'

  get 'static_pages/home'
  get 'about', to: 'static_pages#about'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
