class AddCommentToVendorReviews < ActiveRecord::Migration
  
  def change
    add_column :vendor_reviews, :comment, :text, null: false
  end
  
end
