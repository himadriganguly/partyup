class AddApproveToVendor < ActiveRecord::Migration
  
  def change
  
    add_column :vendors, :approved, :boolean, :default => true, :null => false
    add_index  :vendors, :approved  
  
  end
  
end
