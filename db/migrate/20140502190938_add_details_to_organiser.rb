class AddDetailsToOrganiser < ActiveRecord::Migration
  
  def change
    
    #Personal Details
    add_column :organisers, :first_name, :string, null: false
    add_column :organisers, :last_name, :string, null: false
    add_column :organisers, :mobile, :string, null: false, :limit=>17
    
    #Username
    add_column :organisers, :username, :string, null: false, :limit=>25
    
    add_index :organisers, :username, unique: true
    
  end
  
end
