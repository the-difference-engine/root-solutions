Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/', to: 'homes#index'

  get '/admins/new', to: 'admins#new'
  post '/admins', to: 'admins#create'
end
