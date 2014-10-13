Rhinoart::Engine.routes.draw do  
    devise_for :users, class_name: "Rhinoart::User", module: :devise, 
        :controllers => { :sessions => "rhinoart/sessions", :passwords => "rhinoart/passwords"  } 

    begin
        mount Rhinobook::Engine, at: "library"    
    rescue
    end
    

    scope "(:locale)", locale: /ru|en/ do 
        scope "manage" do 
            resources :users
        end

        root :to => 'pages#index'
        
        # resources :sessions, only: [:new, :create, :destroy]
        # match '/login',  to: 'sessions#new', via: [:get]
        # match '/logout', to: 'sessions#destroy', via: [:delete, :get]

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

        resources :votes do 
            resources :vote_questions do #, only: [:new, :create, :destroy]   
                resources :vote_answer_lists
         #       resources :vote_user_answers
            end    
        end

        resources :votes_passed_users


        match 'vote_answers', to: 'votes#answers', via: 'get'
        match 'vote_current_answers', to: 'votes#current_answers', via: 'get'#, as: :vote_current_answers
        match 'vote_users/:id', to: 'votes#users', via: 'get', as: 'vote_users' 

        #resources :vote_questions do #, only: [:show] do
        #    resources :vote_answer_list
        #    resources :vote_user_answer
        #end

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

