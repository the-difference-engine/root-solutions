Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/', to: 'homes#index'

  get '/resources', to: 'resources#index'
  post '/resources', to: 'resources#create'
  get '/resources/new', to: 'resources#new'
  get '/resources/:id', to: 'resources#show'
end
