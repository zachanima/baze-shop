ActionController::Routing::Routes.draw do |map|
  map.resources :shops do |shop|
    shop.resources :users
    shop.resources :categories
  end

  map.resources :users

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
