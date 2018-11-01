class AddPublishDateToPages < ActiveRecord::Migration[5.1]
  def change
    change_table :rhinoart_pages do |t|
      t.date :publish_date
    end
  end
end
