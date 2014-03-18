require_dependency "rhinoart/application_controller"

module Rhinoart
    class UsersController < ApplicationController
        before_action :set_admin_user, only: [:show, :edit, :update, :destroy]        
        before_filter { access_only_roles %w[ROLE_ADMIN] }


        def index
            store_location
            @users = User.paginate(page: params[:page])
        end

        def show
        end	

        def new
            @user = User.new
        end

        def create
            @user = User.new(user_params)
            if @user.save
                sign_in @user
                flash[:success] = t("_WELCOME")
                redirect_to users_path
            else
                render 'new'
            end
        end

        def edit  
        end

        def update
            if @user.update(user_params)
                flash[:success] = t("_EDIT_USER_SUCCESS")
                redirect_back_or users_path
            else
                render 'edit'
            end
        end  

        def destroy
            @user.destroy
            redirect_to users_path
        end

        private
            # Use callbacks to share common setup or constraints between actions.
            def set_admin_user
                @user = User.find(params[:id])
            end

            # Never trust parameters from the scary internet, only allow the white list through.
            def user_params
                params.require(:user).permit(:name, :email, :password, :password_confirmation)
            end 
    end
end
