class AddCityToOrganiser < ActiveRecord::Migration
  
  def change
    
    add_column :organisers, :city_id, :integer, null: false
    
     add_index :organisers, :city_id
     
  end

end
