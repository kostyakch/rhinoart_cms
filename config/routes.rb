Rhinoart::Engine.routes.draw do
    root :to => 'pages#index'
    
    resources :sessions, only: [:new, :create, :destroy]

    #match '/signup',  to: 'users#new', via: [:get]
    #match '/users',  to: 'users#create', :as => :users, via: [:get, :post]
    match '/login',  to: 'sessions#new', via: [:get]
    match '/logout', to: 'sessions#destroy', via: [:delete, :get]

    match '/page/:id/show_hide' => 'pages#showhide', :as => :page_showhide, via: [:get]
    match '/page/:parent_id/list' => 'pages#children', :as => :page_children, via: [:get]
    match '/page/:parent_id/new' => 'pages#new', :as => :new_children_page, via: [:get]
    match '/page/tree' => 'pages#tree', :as => :pages_tree, via: [:get]
    match '/page/field_page_add' => 'pages#field_page_add', :as => :pages_field_add, via: [:get]
    resources :pages

    resources :page_comments
    resources :page_fields, only: [:new, :create, :destroy], via: :js


    match '/structures/:parent_id/new' => 'structures#new', :as => :new_children_structures, via: [:get]
    resources :structures

    resources :users
    resources :settings
    resources :dashboard

    resources :galleries


    #upload files
    match 'assets/upload_image' => 'assets#upload_image', via: [:get]#, via: :js
    match 'assets/upload_file' => 'assets#upload_file' , via: [:get]
    match 'assets/image_list' => 'assets#image_list', via: [:get]

    match '/gallery_images/:gallery_id/new' => 'gallery_images#new', :as => :new_image_gallery, via: [:get]
    match '/gallery_images/:gallery_id/uppload' => 'gallery_images#uppload', :as => :uppload_images, via: [:get]
    resources :gallery_images
end
