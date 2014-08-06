require_dependency "rhinoart/application_controller"

module Rhinoart
	class VotesController < BaseController
		before_action :set_vote, only: [:show, :edit, :update, :destroy]
        #skip_before_filter :check_if_user_has_admin_role

		def index
            store_location
            @votes = Vote.all
        end

        def show
        end

        def new
            @vote = Vote.new
        end

        def create
            @vote = Vote.new(vote_attributes)
			#@vote.user_id = current_user.id

            if @vote.save
                flash[:info] = t('_SUCCESSFULLY_CREATED')

                if params[:continue].present? 
                    redirect_to edit_vote_path(@vote)
                else
                    redirect_back_or votes_path
                end
            else  
                render 'new'
            end
        end

        def edit  
        end

        def update
            if @vote.update(vote_attributes)
                flash[:info] = t('_PAGE_SUCCESSFULLY_UPDATED')
                if params[:continue].present? 
                    render action: "edit"
                else
                    redirect_back_or votes_path
                end
            else
                render action: "edit"
            end
        end  

        def destroy
           @vote.destroy

            respond_to do |format|
                format.html { redirect_to votes_path }
            end
        end

        def answers
            @vote_answers = VoteUserAnswer.select(:started_at).distinct
        end

        def current_answers
            # @vote_user_answers = VoteUserAnswer.where("started_at = ?", params[:parent].to_datetime).eager_load(:vote_question).to_a
            @vote_user_answers = VoteUserAnswer.where("started_at = ?", params[:parent].to_datetime)
            p @vote_user_answers
        end
        
	private
        def set_vote
            @vote = Vote.find(params[:id])
        end

        def vote_attributes
            params.require(:vote).permit! 
        end 

	end
end