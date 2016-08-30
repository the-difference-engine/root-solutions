Rails.application.routes.draw do
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
  devise_for :users

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/', to: 'homes#index'

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
