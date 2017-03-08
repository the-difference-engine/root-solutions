Rails.application.routes.draw do

  root to: 'pages#about_us', as: :about_us
  get '/about_us', to: 'pages#about_us'
  get '/work_with_us', to: 'pages#work_with_us', as: :work_with_us
  post '/work_with_us', to: 'pages#work_with_us_email'
  get '/projects', to: 'pages#projects'
  get '/learn', to: 'pages#learn', as: :learn
  get 'learn/behavior_design', to: 'learn#behavior_design'
  get 'learn/our_process', to: 'learn#our_process'
  get '/learn/why_behavior', to: 'learn#why_behavior'
  get '/careers', to: 'pages#careers', as: :careers
  get '/partners', to: 'pages#partners'
  get '/team', to: 'pages#team'
  get '/mission', to: 'pages#mission'
  get '/donate', to: 'pages#donate'
  get '/search_filter', to: 'searches#search'
  get '/search/:id', to: 'searches#show'
  get '/search', to: 'searches#index'

  resources :news_sources
  devise_for :users, :path => '', :path_names => {:sign_in => 'login', :sign_out => 'logout'}, controllers: {registrations: 'users/registrations'}
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
  get '/dashboard', to: 'admins#dashboard'
  get '/resources/export', to: 'resources#export_resources', as: :export_resources
  get '/resources/import', to: 'resources#import'
  post '/resources/import', to: 'resources#import_resources'
  resources :resources

  resources :attachments

  get '/admins', to: 'admins#index'
  get '/admins/new', to: 'admins#new'
  get '/admins/:id', to: 'admins#show'
  post '/admins', to: 'admins#create'
  get '/admins/:id/edit', to: 'admins#edit'
  patch '/admins/:id', to: 'admins#update'
  delete '/admins/:id', to: 'admins#destroy'

as :admin do
  get '/accounts/new', to: 'accounts#new'
  post '/accounts', to: 'accounts#create'
  get '/accounts/:id', to: 'accounts#edit'
  patch '/accounts/:id', to: 'accounts#update'
end

  namespace :api do
    namespace :v1 do
      resources :resources
    end
  end

  post '/email_subscriptions', to: 'email_subscriptions#create'
end
