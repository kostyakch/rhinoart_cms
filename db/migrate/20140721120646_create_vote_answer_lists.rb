class CreateVoteAnswerLists < ActiveRecord::Migration
  def change
    create_table :rhinoart_vote_answer_lists do |t|
      t.integer :position
      t.boolean :active
      t.text :answer
      t.string :field_type
      t.belongs_to :vote_question

      t.timestamps
    end
  end
end
