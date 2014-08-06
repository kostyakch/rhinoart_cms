class CreateVoteQuestions < ActiveRecord::Migration
  def change
    create_table :rhinoart_vote_questions do |t|
      t.boolean :active
      t.boolean :required
      t.integer :position
      t.text :description
      t.belongs_to :vote
     
      t.timestamps
    end


  end
end
