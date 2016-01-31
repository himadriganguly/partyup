class CreateProposals < ActiveRecord::Migration
  
  def change
    
    create_table :proposals do |t|
      
      t.text :description, null: false
      t.integer :price, null: false
      
      t.belongs_to :request, null: false
      t.belongs_to :vendor, null: false
      
      t.timestamps
    end
    
    add_index :proposals, :request_id
    
    add_index :proposals, :vendor_id
    
  end
  
end
