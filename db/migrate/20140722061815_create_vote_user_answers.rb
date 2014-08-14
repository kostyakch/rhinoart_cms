class CreateVoteUserAnswers < ActiveRecord::Migration
  def change
    create_table :rhinoart_vote_user_answers do |t|
      t.text :content
      t.belongs_to :vote_answer_list
      t.belongs_to :votes_passed_user

      t.timestamps
    end
  end
end
