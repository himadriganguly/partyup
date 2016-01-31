class ChangeCategoryToForeignKeyInRequests < ActiveRecord::Migration
  
  def self.up
    
    remove_column :requests, :category
    
    add_column :requests, :category_id, :integer, null: false
    
    add_index :requests, :category_id
    
  end
  
  def self.down
    
    add_column :requests, :category, :string, null: false
    
    remove_column :requests, :category_id
    
  end
  
end
