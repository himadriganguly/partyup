class ChangeCategoryToForeignKeyInVendor < ActiveRecord::Migration
  
  def self.up
    
    remove_column :vendors, :category
    
    add_column :vendors, :category_id, :integer, null: false
    
    add_index :vendors, :category_id
    
  end
  
  def self.down
    
    add_column :vendors, :category, :string, null: false
    
    remove_column :vendors, :category_id
    
  end
  
end
