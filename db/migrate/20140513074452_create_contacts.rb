class CreateContacts < ActiveRecord::Migration
  
  def change
    
    create_table :contacts do |t|
      
      t.string :name, null: false
      t.string :email, null: false
      t.text :description, null: false

      t.timestamps
      
      t.belongs_to :contact_reason, null: false
      
    end
    
    add_index :contacts, :contact_reason_id
    
  end
  
end
