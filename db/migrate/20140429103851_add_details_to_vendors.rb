class AddDetailsToVendors < ActiveRecord::Migration
  def change
    
    #Personal Details
    add_column :vendors, :first_name, :string, null: false
    add_column :vendors, :last_name, :string, null: false
    add_column :vendors, :mobile, :string, null: false, :limit=>17
    
    #Business Details
    add_column :vendors, :business_name, :string, null: false
    add_column :vendors, :est_year, :integer, null: false, :limit =>2
    add_column :vendors, :category, :string, null: false
    add_column :vendors, :city, :string, null: false, :limit=>50
    
    #Username
    add_column :vendors, :username, :string, null: false, :limit=>25
    
    add_index :vendors, :username, unique: true
    
  end
  
end
