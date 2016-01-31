class AddRepliedToContacts < ActiveRecord::Migration
  
  def change
    
    add_column :contacts, :replied, :boolean, :default => false, :null => false
    add_index  :contacts, :replied
    
  end
  
end
