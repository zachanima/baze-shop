ActionController::Routing::Routes.draw do |map|
  map.resources :shops do |shop|
    shop.resources :users
  end

  map.resources :users

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
