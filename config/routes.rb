Rails.application.routes.draw do
  resources :news_sources
  devise_for :users, :path => '', :path_names => {:sign_in => 'login', :sign_out => 'logout'}
  resources :cognitive_bia do
    collection do
      post :import
    end
  end
  resources :building_blocks do
    collection do
      post :import
    end
  end
  resources :building_block_substeps do
    collection do
      post :import
    end
  end
  resources :environmental_tags do
    collection do
      post :import
    end
  end
  resources :environmental_subtags do
    collection do
      post :import
    end
  end
  resources :world_regions do
    collection do
      post :import
    end
  end
  resources :resource_types do
    collection do
      post :import
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/', to: 'homes#index'

  get '/dashboard', to: 'admins#dashboard'
  get '/resources/export', to: 'resources#export_resources', as: :export_resources
  post '/resources/import', to: 'resources#import_resources'
  resources :resources
  get '/search', to: 'searches#index'

  resources :attachments

  get '/admins', to: 'admins#index'
  get '/admins/new', to: 'admins#new'
  get '/admins/:id', to: 'admins#show'
  post '/admins', to: 'admins#create'
  get '/admins/:id/edit', to: 'admins#edit'
  patch '/admins/:id', to: 'admins#update'
  delete '/admins/:id', to: 'admins#destroy'


  namespace :api do
    namespace :v1 do
      resources :resources
    end
  end
end
