class CreateVendorReviews < ActiveRecord::Migration
  def change
    create_table :vendor_reviews do |t|
      
      t.string :request_title, null: false
      t.string :request_venue, null: false
      t.string :organiser, null: false
      t.date :date, null: false
      t.integer :quality, null: false, default: 0, :limit=>1
      t.integer :service, null: false, default: 0, :limit=>1
      
      t.belongs_to :vendor, null: false
      
      t.timestamps
    end
    
    add_index :vendor_reviews, :vendor_id
    
  end
end
