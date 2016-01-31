class RemoveAvatarFromVendorProfile < ActiveRecord::Migration
  
  def self.up
    remove_attachment :vendor_profiles, :avatar  
  end
  
  def self.down
    add_attachment :vendor_profiles, :avatar
  end
  
end
