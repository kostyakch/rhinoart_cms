require_dependency "rhinoart/application_controller"

module Rhinoart
	class VoteQuestionsController < BaseController
		before_action :set_vote_question, only: [:show, :edit, :update, :destroy]
    #skip_before_filter :check_if_user_has_admin_role

		def index
      store_location
      @vote_questions = VoteQuestion.where("vote_id = ?", params[:vote_id])


    end

    def show
    end	

    def new
      @vote_question = VoteQuestion.new
    end

    def create
      @vote_question = VoteQuestion.new(vote_question_attributes)
      @vote_question.vote_id = params[:vote_id]

      if @vote_question.save
        flash[:info] = t('_SUCCESSFULLY_CREATED')

        if params[:continue].present? 
          redirect_to edit_vote_vote_question_path(@vote)
        else
          redirect_back_or vote_vote_questions_path
        end
      else  
        render 'new'
      end
    end

    def edit  
    end

    def update
        if @vote_question.update(vote_question_attributes)
            flash[:info] = t('_PAGE_SUCCESSFULLY_UPDATED')
            
            if params[:continue].present? 
                render action: "edit"
            else
                redirect_back_or vote_vote_questions_path
            end
        else
            render action: "edit"
        end
    end  

    def destroy
       @vote_question.destroy

        respond_to do |format|
            format.html { redirect_to vote_vote_questions_path }
        end
    end
	private
        def set_vote_question
            @vote_question = VoteQuestion.find(params[:id])
        end

        def vote_question_attributes
            params.require(:vote_question).permit! 
        end 

	end
end