class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      
      t.string :title, null: false
      t.string :city, :limit=>50, null: false
      t.string :venue, null: false
      t.string :category, null: false
      t.integer :hours, null: false
      t.integer :budget, null: false
      t.integer :guests, null: false
      t.date :date, null: false
      t.time :time, null: false
      t.text :description, null: false
          
      t.belongs_to :organiser, null: false
      
      t.timestamps
    end
    
    add_index :requests, :organiser_id
    
  end
end
