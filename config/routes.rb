Rhinoart::Engine.routes.draw do  
    devise_for :users, class_name: "Rhinoart::User", module: :devise    

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

#         new_user_session GET      /users/sign_in(.:format)                                devise/sessions#new
#             user_session POST     /users/sign_in(.:format)                                devise/sessions#create
#     destroy_user_session DELETE   /users/sign_out(.:format)                               devise/sessions#destroy
#            user_password POST     /users/password(.:format)                               devise/passwords#create
#        new_user_password GET      /users/password/new(.:format)                           devise/passwords#new
#       edit_user_password GET      /users/password/edit(.:format)                          devise/passwords#edit
#                          PATCH    /users/password(.:format)                               devise/passwords#update
#                          PUT      /users/password(.:format)                               devise/passwords#update
# cancel_user_registration GET      /users/cancel(.:format)                                 devise/registrations#cancel
#        user_registration POST     /users(.:format)                                        devise/registrations#create
#    new_user_registration GET      /users/sign_up(.:format)                                devise/registrations#new
#   edit_user_registration GET      /users/edit(.:format)                                   devise/registrations#edit
#                          PATCH    /users(.:format)                                        devise/registrations#update
#                          PUT      /users(.:format)                                        devise/registrations#update
#                          DELETE   /users(.:format)                                        devise/registrations#destroy

