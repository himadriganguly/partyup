class AddAttachmentsToVendorProfile < ActiveRecord::Migration
  
  def self.up
    
    add_attachment :vendor_profiles, :avatar
    
    add_attachment :vendor_profiles, :pic1
    add_attachment :vendor_profiles, :pic2
    add_attachment :vendor_profiles, :pic3
    add_attachment :vendor_profiles, :pic4
    
  end
  
  def self.down
    
    remove_attachment :vendor_profiles, :avatar
    
    remove_attachment :vendor_profiles, :pic1
    remove_attachment :vendor_profiles, :pic2
    remove_attachment :vendor_profiles, :pic3
    remove_attachment :vendor_profiles, :pic4
    
  end
  
end
