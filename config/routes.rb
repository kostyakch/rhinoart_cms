Rhinoart::Engine.routes.draw do  
  # namespace :api, :path => '/api' do
  #   scope :v1 do  
  #     resources :pages, only: :show
  #   end
  # end
  
  scope :admin do
    devise_for Rhinoart.device_namespace, Rhinoart.devise_routes
  

    scope "(:locale)", locale: /ru|en/ do 
      scope :manage do
        resources :users
      end

      root :to => 'dashboard#index'

      # Pages
      resources :pages do
        member do
          get 'showhide'                
          get 'children'
          get 'new', as: :new_children
        end  
        get 'tree', on: :collection
        get 'field_page_add', on: :collection

        get 'up'
        get 'down'
      end

      # Page structures
      resources :structures, only: [:index, :new, :create, :edit, :destroy] do
        member do
          get 'new', as: :new_child
          get 'children'
          get 'showhide'
        end            
      end 

      resources :page_comments
      resources :page_fields, only: [:new, :create, :destroy], via: :js
      
      resources :settings
      resources :dashboard

      #upload files
      scope :fileworks do
        match 'upload_image' => 'fileworks#upload_image', via: [:get, :post]#, via: :js
        match 'upload_file' => 'fileworks#upload_file' , via: [:get, :post]
        match 'image_list' => 'fileworks#image_list', via: [:get]
      end

      get 'caches/clear' => 'caches#clear'

      resources :helps, only: :index
    end
  end
end

