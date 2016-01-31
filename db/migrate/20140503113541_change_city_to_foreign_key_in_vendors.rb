class ChangeCityToForeignKeyInVendors < ActiveRecord::Migration
  
  def self.up
    
    remove_column :vendors, :city
    
    add_column :vendors, :city_id, :integer
    
    add_index :vendors, :city_id
    
  end
  
  def self.down
    
    add_column :vendors, :city, :string, null: false, :limit=>50
    
    remove_column :vendors, :city_id
    
  end
  
end
