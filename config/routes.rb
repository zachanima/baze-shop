ActionController::Routing::Routes.draw do |map|
  map.resources :categories

  map.resources :shops do |shop|
    shop.resources :users
  end

  map.resources :users

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
