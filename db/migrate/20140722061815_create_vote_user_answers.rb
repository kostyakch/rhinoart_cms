class CreateVoteUserAnswers < ActiveRecord::Migration
  def change
    create_table :rhinoart_vote_user_answers do |t|
      t.text :content
      t.datetime :started_at
      t.belongs_to :vote_question

      t.timestamps
    end
  end
end
