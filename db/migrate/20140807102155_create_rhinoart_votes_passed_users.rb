class CreateRhinoartVotesPassedUsers < ActiveRecord::Migration
  def change
    create_table :rhinoart_votes_passed_users do |t|
      t.belongs_to :vote
      t.belongs_to :user
      t.string :ip_address
      t.string :num_session

      t.timestamps
    end

    add_index :rhinoart_votes_passed_users, [:ip_address, :num_session], unique: true
  end
end
