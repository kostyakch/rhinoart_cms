class CreateVoteQuestions < ActiveRecord::Migration
  def change
    create_table :rhinoart_vote_questions do |t|
      t.boolean :active
      t.boolean :required
      t.integer :position
      t.text :question
      t.belongs_to :vote
     
      t.timestamps
    end

    add_index :rhinoart_vote_questions, [:vote_id, :question], unique: true
  end
end
