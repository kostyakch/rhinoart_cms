class AddPathToPageFields < ActiveRecord::Migration
  def change
    change_table :rhinoart_page_fields do |t|
      t.string :path
    end   	
  end
end
