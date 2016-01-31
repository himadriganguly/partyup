class CreateVendorProfiles < ActiveRecord::Migration
  def change
    create_table :vendor_profiles do |t|
      
      t.text :about
      t.string :skills
      t.string :youtubelink
      
      t.belongs_to :vendor, null: false
      
      t.timestamps
    end
  end
end
