Rails.application.routes.draw do
  resources :cognitive_bia
  resources :building_blocks
  resources :building_block_substeps
  resources :environmental_tags
  resources :environmental_subtags
  resources :world_regions
  resources :resource_types
  devise_for :users, :path => '', :path_names => {:sign_in => 'login', :sign_out => 'logout'}

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/', to: 'homes#index'

  get '/dashboard', to: 'admins#dashboard'
#SAQ to do: create route for admin/dashbaord to admins/dashboard.html.erb
  get '/resources/export', to: 'resources#export_resources', as: :export_resources
  resources :resources
  resources :attachments

  get '/admins/new', to: 'admins#new'
  post '/admins', to: 'admins#create'
  

  namespace :api do
    namespace :v1 do
      resources :resources
    end
  end
end
