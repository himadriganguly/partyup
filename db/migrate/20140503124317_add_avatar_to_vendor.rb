class AddAvatarToVendor < ActiveRecord::Migration
  
  def self.up
    
    add_attachment :vendors, :avatar
    
  end
  
  def self.down
    
    remove_attachment :vendors, :avatar
    
  end
 
end
