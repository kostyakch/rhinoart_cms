Rhinoart::Engine.routes.draw do  
    devise_for :users, class_name: "Rhinoart::User", module: :devise, 
        :controllers => { :sessions => "rhinoart/sessions", :passwords => "rhinoart/passwords"  } 

    scope "(:locale)", locale: /ru|en/ do 
        scope "manage" do 
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

        resources :galleries

        #upload files
        scope :fileworks do
            match 'upload_image' => 'fileworks#upload_image', via: [:get, :post]#, via: :js
            match 'upload_file' => 'fileworks#upload_file' , via: [:get, :post]
            match 'image_list' => 'fileworks#image_list', via: [:get]
        end

        match '/gallery_images/:gallery_id/new' => 'gallery_images#new', :as => :new_image_gallery, via: [:get]
        match '/gallery_images/:gallery_id/uppload' => 'gallery_images#uppload', :as => :uppload_images, via: [:get]
        resources :gallery_images
    end
end

