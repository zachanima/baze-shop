ActionController::Routing::Routes.draw do |map|
  map.resources :shops do |shop|
    shop.resources :categories
    shop.resources :products
    shop.resources :users
  end

  map.resources :users
  map.resources :products

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
