require_dependency "rhinoart/application_controller"

module Rhinoart
  class PageCommentsController < ApplicationController
    before_action :set_admin_page_comment, only: [:edit, :update, :destroy]
    before_filter { access_only_roles %w[ROLE_ADMIN ROLE_EDITOR] }

    def index
    	store_location
      @page_comments = PageComment.where('parent_id is null').order('page_id, approved, updated_at').paginate(page: params[:page])
    end

    def edit
    end

    def update
      if @page_comment.update(admin_page_comment_params)
        flash[:info] = t('_PAGE_SUCCESSFULLY_UPDATED')
        if params[:continue].present? 
          render action: "edit"
        else
          redirect_back_or admin_page_comments_path
        end      
      else
        render action: "edit"
      end   
    end  

    def destroy
      @page_comment.destroy

      flash[:info] = t('_PAGE_COMMENT_SUCCESSFULLY_DELITED')
      redirect_back_or admin_page_comments_path
    end

      private
          # Use callbacks to share common setup or constraints between actions.
          def set_admin_page_comment
              @page_comment = PageComment.find(params[:id])    
          end

          # Never trust parameters from the scary internet, only allow the white list through.
          def admin_page_comment_params
              params.require(:page_comment).permit(:comment, :approved)
          end

  end
end
