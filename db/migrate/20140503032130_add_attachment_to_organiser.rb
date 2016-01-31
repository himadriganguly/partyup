class AddAttachmentToOrganiser < ActiveRecord::Migration
  
  def self.up
    
    add_attachment :organisers, :avatar
      
  end
  
  def self.down
    
    remove_attachment :organisers, :avatar
    
  end
  
end
