Tipegoo::Application.routes.draw do




  resources :users, :only=>[:edit,:update]
  resources :contacts, :only=>[:new,:create]

  match "sign_up"=>"users#new", :via=>:get
  match "sign_up"=>"users#create", :via=>:post
  match "verify" => "users#name_validation", :via=>:get

  match "sign_in"=>"sessions#new", :via=>:get
  match "sign_in"=>"sessions#create", :via=>:post
  match "sign_out"=>"sessions#destroy", :via=>:get
  match "password"=>"sessions#password", :via=>:get
  match "password"=>"sessions#password_send", :via=>:post
  
  match "faq"=>"home#faq", :via=>:get
  match "banners"=>"home#banners", :via=>:get
  match "benefits"=>"home#benefits", :via=>:get


  match "office"=> redirect("/office/welcome")
 
  namespace :admin do
    resources :setups, :only=>[:new,:create] 
    resources :bills, :only=>[:index,:edit,:update] 
  end
  
  namespace :office do
    resources :users, :only=>[:show, :edit, :update]
    resources :addresses, :only=>[:edit, :update]
    resources :bank_accounts, :only=>[:edit, :update]
    resources :comms, :only=>[:index]
    resources :payouts, :only=>[:index]
    resources :supports, :only=>[:new,:create]
    resources :cycles, :only=>[:index, :show] do 
      member do 
        get "info"
      end
    end
    match "products" => "home#products", :as=>:products
    match "welcome"=>"home#index", :via=>:get
    match "banners"=>"home#banners", :via=>:get
    match 'bill/:token'=> "bills#show", :as=> :bill
    get "matrix/monitor"
    match "matrix/level/:level"=>"matrix#level", :as=>:matrix_level
    get "matrix/upline"
    match "matrix/downline/:id"=>"matrix#downline"
    match "password/change"=>"users#password_form", :via=>:get
    match "password/change"=>"users#password_update", :via=>:put

  end

  post "payments/via"

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
   root :to => 'home#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
