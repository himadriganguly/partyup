class AddDescriptionToClarification < ActiveRecord::Migration
  
  def change
    
    add_column :clarifications, :description, :text, null: false
    
  end
  
end
