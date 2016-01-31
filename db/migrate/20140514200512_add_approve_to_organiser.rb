class AddApproveToOrganiser < ActiveRecord::Migration
  
  def change
    
    add_column :organisers, :approved, :boolean, :default => true, :null => false
    add_index  :organisers, :approved  
    
  end
  
end
