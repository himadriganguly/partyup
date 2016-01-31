class ChangeCityToForeignKeyInRequests < ActiveRecord::Migration
  
  def self.up
    
    remove_column :requests, :city
    
    add_column :requests, :city_id, :integer
    
    add_index :requests, :city_id
    
  end
  
  def self.down
    
    add_column :requests, :city, :limit=>50, null: false
    
    remove_column :requests, :city_id
    
  end
  
end
