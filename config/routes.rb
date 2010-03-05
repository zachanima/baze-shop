ActionController::Routing::Routes.draw do |map|
  map.resources :option_groups do |option_group|
    option_group.resources :options
  end

  map.resources :orders

  map.resources :products do |product|
    product.resources :images
  end

  map.resources :shops do |shop|
    shop.resources :categories do |category|
      category.resources :categorizations
    end
    shop.resources :categorizations, :collection => { :multiple => :post }
    shop.resources :categorizations do |categorization|
      categorization.resources :order
    end
    shop.resources :orders
    shop.resources :products
    shop.resources :users, :collection => {
      :import => :get,
      :upload => :post,
      :import_create => :put
    }
  end

  map.resources :users, :collection => {
    :import => :get
  }

  map.connect ':id', :controller => 'shops', :action => 'show'

  map.root :controller => :shops
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
