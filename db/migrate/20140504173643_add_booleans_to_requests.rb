class AddBooleansToRequests < ActiveRecord::Migration
 
  def change
    
    add_column :requests, :accept_proposal, :boolean, :default=> true, null: false
    
    add_column :requests, :vendor_select, :boolean, :default=> false, null: false
    
    add_column :requests, :cancel, :boolean, :default=> false, null: false
    
  end
  
end
