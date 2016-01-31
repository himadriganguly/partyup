class CreateClarifications < ActiveRecord::Migration
  def change
    create_table :clarifications do |t|
      
      t.belongs_to :request, null: false
      
      t.references :clarify, polymorphic: true, null: false
      
      t.timestamps
    end
    
    add_index :clarifications, :request_id
    
    add_index :clarifications, :clarify_id
    add_index :clarifications, :clarify_type
    
  end
end
