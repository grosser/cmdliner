ActionController::Routing::Routes.draw do |map|
  map.root :controller => :commands
  map.login '/login', :controller => "users", :action => "new"

  map.resources :users
  map.resources :commands, :only=>[:index, :show]
end