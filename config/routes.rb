ActionController::Routing::Routes.draw do |map|
  map.resources :movies

  map.test '/test', :controller => 'test', :action => 'test'

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
