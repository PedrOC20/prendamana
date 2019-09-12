Rails.application.routes.draw do
  root to: 'bimby_raises#home'

  resources :bimby_raises
end
