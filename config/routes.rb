ActionController::Routing::Routes.draw do |map|
  map.resources :shops do |shop|
    shop.resources :categories do |category|
      category.resources :categorizations
    end
    shop.resources :categorizations
    shop.resources :products
    shop.resources :users, :collection => {
      :import => :get,
      :upload => :post,
      :import_create => :put
    }
  end

  map.resources :users, :collection => {
    :import => :get,
    :upload => :post,
    :multiple_create => :put
  }
  map.resources :products
  map.resources :option_groups do |option_group|
    option_group.resources :options
  end

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
