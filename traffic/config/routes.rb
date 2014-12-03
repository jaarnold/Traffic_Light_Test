Rails.application.routes.draw do
  
  resources :junctions

  get '/next', to: 'junctions#next'

  root 'welcome#index'

end
