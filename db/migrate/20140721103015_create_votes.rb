class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.string, :name
      t.boolean, :active
      t.datetime, :started_at
      t.datetime :finished_at
      t.references :users, polymorphic: true 

      t.timestamps
    end

    add_index :votes, :name, unique: true
  end
end
