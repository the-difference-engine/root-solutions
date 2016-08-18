Rails.application.routes.draw do
  resources :building_blocks
  resources :building_block_substeps
  resources :environmental_tags
  resources :environmental_subtags
  resources :world_regions
  resources :resource_types
  devise_for :users
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/', to: 'homes#index'

  get '/resources/export', to: 'resources#export_resources', as: :export_resources
  resources :resources
  resources :tags
  resources :attachments

  get '/admins/new', to: 'admins#new'
  post '/admins', to: 'admins#create'

  namespace :api do
    namespace :v1 do
      resources :resources
    end
  end
end
