class CreateVoteUserAnswers < ActiveRecord::Migration
  def change
    create_table :vote_user_answers do |t|
      t.text :content
      t.belongs_to :vote_question

      t.timestamps
    end
  end
end
