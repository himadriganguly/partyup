class AddCommentToContacts < ActiveRecord::Migration
  
  def change
    add_column :contacts, :comment, :text, null: false
  end
end
