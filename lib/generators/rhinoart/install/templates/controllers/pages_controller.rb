class PagesController < ApplicationController
    def index
        if params[:url] == 'index'
            render :template => 'shared/not_found', :status => 404
            return
        end

        if !@page = Rhinoart::Page.find_by_path('index')
            render :template => 'shared/not_found', :status => 404
        end          
    end 

    def internal
        if params[:url] == 'index'
            render :template => 'shared/not_found', :status => 404
            return
        end

        if !@page = Rhinoart::Page.find_by_path(params[:url])
            render :template => 'shared/not_found', :status => 404
            return
        end    

        redirect_to @page.field('redirect_to'), status: :moved_permanently if @page.field('redirect_to').present?    
    end

end