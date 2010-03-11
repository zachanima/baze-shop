ActionController::Routing::Routes.draw do |map|
  map.login 'shops/:shop_id/login', :controller => 'user_sessions', :action => 'new', :conditions => { :method => :get }
  map.login 'shops/:shop_id/login', :controller => 'user_sessions', :action => 'create', :conditions => { :method => :post }
  map.logout 'shops/:shop_id/logout', :controller => 'user_sessions', :action => 'destroy'
  map.logout 'shops/:shop_id/orders/increment/:id', :controller => 'orders', :action => 'increment', :conditions => { :method => :post }
  map.logout 'shops/:shop_id/orders/decrement/:id', :controller => 'orders', :action => 'decrement', :conditions => { :method => :post }

  map.resources :option_groups do |option_group|
    option_group.resources :options, :collection => { :sort => :post }
  end

  map.resources :orders

  map.resources :templates do |template|
    template.resources :images
  end

  map.resources :shops do |shop|
    shop.resources :categories, :collection => { :sort => :post } do |category|
      category.resources :products
    end
    shop.resources :products, :collection => { :multiple => :post, :sort => :post }
    shop.resources :products do |product|
      product.resources :order
    end
    shop.resources :orders
    shop.resources :users, :collection => {
      :import => :get,
      :upload => :post,
      :import_create => :put
    } do |user|
      user.resources :orders, :collection => {
        :review => :get,
        :accept => :post
      }
    end
  end

  map.resources :user_sessions

  map.resources :users, :collection => {
    :import => :get
  }



  map.root :controller => :shops
  map.connect ':id', :controller => 'shops', :action => 'show'
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
