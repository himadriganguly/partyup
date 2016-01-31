class CreateHighlights < ActiveRecord::Migration
  def change
    create_table :highlights do |t|
      
      t.string :title, null: false
      t.text :description, null: false
      
      t.belongs_to :vendor, null: false
      
      t.timestamps
    end
    
    add_index :highlights, :vendor_id
    
  end
end
