class CreateFavourites < ActiveRecord::Migration
  def change
    create_table :favourites do |t|
      
      t.belongs_to :request, null: false
      t.belongs_to :vendor, null: false
      
      t.timestamps
    end
    
    add_index :favourites, [:request_id, :vendor_id], unique: true
    
  end
end
