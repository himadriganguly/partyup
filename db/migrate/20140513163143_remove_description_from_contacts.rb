class RemoveDescriptionFromContacts < ActiveRecord::Migration
  
  def change
    remove_column :contacts, :description, :text
  end
  
end
