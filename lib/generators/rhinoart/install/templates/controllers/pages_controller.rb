class PagesController < ApplicationController
    def index
        if params[:url] == 'index'
            render :template => 'site/not_found', :status => 404
            return
        end

        if !@page = Rhinoart::Page.find_by_path('index')
            render :template => 'site/not_found', :status => 404
        end  

        redirect_to @page.field('redirect_to'), status: :moved_permanently if @page.field('redirect_to').present?
    end 

    def internal
        if params[:url] == 'index'
            render :template => 'site/not_found', :status => 404
            return
        end

        if !@page = Rhinoart::Page.find_by_path(params[:url])
            render :template => 'site/not_found', :status => 404
            return
        end        
    end

end