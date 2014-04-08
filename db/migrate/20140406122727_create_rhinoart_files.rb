class CreateRhinoartFiles < ActiveRecord::Migration
  def change
    create_table :rhinoart_files do |t|
    	t.references :attachable, polymorphic: true
		t.string :attachable_type

		t.string :file
		t.string :file_content_type

		t.timestamps
    end
  end
end
