require_dependency "rhinoart/application_controller"

module Rhinoart
	class VoteAnswerListsController < BaseController
		before_action :set_vote_answer_list, only: [:show, :edit, :update, :destroy]
    #skip_before_filter :check_if_user_has_admin_role

		def index
      store_location
      @vote_answer_lists = VoteAnswerList.where("vote_question_id = ?", params[:vote_question_id])


    end

    def show
    end	

    def new
      @vote_answer_list = VoteAnswerList.new
    end

    def create
      @vote_answer_list = VoteAnswerList.new(vote_answer_list_attributes)
      @vote_answer_list.vote_question_id = params[:vote_question_id]

      if @vote_answer_list.save
        flash[:info] = t('_SUCCESSFULLY_CREATED')

        if params[:continue].present? 
          redirect_to edit_vote_vote_question_vote_answer_list_path(@vote)
        else
          redirect_back_or vote_vote_question_vote_answer_lists_path
        end
      else  
        render 'new'
      end
    end

    def edit  
    end

    def update
        if @vote_answer_list.update(vote_answer_list_attributes)
            flash[:info] = t('_PAGE_SUCCESSFULLY_UPDATED')
            
            if params[:continue].present? 
                render action: "edit"
            else
                redirect_back_or vote_vote_question_vote_answer_lists_path
            end
        else
            render action: "edit"
        end
    end  

    def destroy
       @vote_answer_list.destroy

        respond_to do |format|
            format.html { redirect_to vote_vote_question_vote_answer_lists_path }
        end
    end
	private
        def set_vote_answer_list
            @vote_answer_list = VoteAnswerList.find(params[:id])
        end

        def vote_answer_list_attributes
            params.require(:vote_answer_list).permit! 
        end 

	end
end