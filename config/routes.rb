ActionController::Routing::Routes.draw do |map|
  map.root :controller => 'home'
  map.login '/login', :controller => "users", :action => "new"

  map.resources :users
end