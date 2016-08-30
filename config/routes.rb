Rails.application.routes.draw do
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
