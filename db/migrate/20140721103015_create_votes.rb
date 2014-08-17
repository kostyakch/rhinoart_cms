class CreateVotes < ActiveRecord::Migration
  def change
    create_table :rhinoart_votes do |t|
      t.string :name
      t.boolean :active
      t.datetime :started_at
      t.datetime :finished_at

      t.timestamps
    end

    add_index :rhinoart_votes, :name, unique: true
  end
end
