class AddWinnerToProposal < ActiveRecord::Migration
  
  def change
  
    add_column :proposals, :is_winner, :boolean, :default=> false, null: false
    
  end
  
end
