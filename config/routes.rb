Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/', to: 'homes#index'


  resources :resources
  resources :tags
  resources :building_blocks
  resources :attachments

  get '/admins/new', to: 'admins#new'
  post '/admins', to: 'admins#create'

  namespace :api do
    namespace :v1 do
      resources :resources
    end
  end
end
