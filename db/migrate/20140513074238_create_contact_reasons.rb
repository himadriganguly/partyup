class CreateContactReasons < ActiveRecord::Migration
  
  def change
    create_table :contact_reasons do |t|
      t.string :reason, null: false

      t.timestamps
    end
    
    add_index :contact_reasons, :reason, unique: true
      
  end
  
end
