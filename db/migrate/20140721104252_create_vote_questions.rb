class CreateVoteQuestions < ActiveRecord::Migration
  def change
    create_table :vote_questions do |t|
      t.boolean, :active
      t.boolean, :required
      t.integer, :position
      t.text, :description
      t.belongs_to :vote
     
      t.timestamps
    end

    add_index :vote_questions, [:vote_id, :position], unique: true   
  end
end
