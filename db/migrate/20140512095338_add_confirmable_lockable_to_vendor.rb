class AddConfirmableLockableToVendor < ActiveRecord::Migration
  
  def change
    
    ## Confirmable
    add_column :vendors, :confirmation_token, :string
    add_column :vendors, :confirmed_at, :datetime
    add_column :vendors, :confirmation_sent_at, :datetime
    add_column :vendors, :unconfirmed_email, :string # Only if using reconfirmable
    
    ## Lockable
    add_column :vendors, :failed_attempts, :integer, default: 0, null: false # Only if lock strategy is :failed_attempts
    add_column :vendors, :unlock_token, :string # Only if unlock strategy is :email or :both
    add_column :vendors, :locked_at, :datetime
     
    add_index :vendors, :confirmation_token,   unique: true
    add_index :vendors, :unlock_token,         unique: true
    
  end
end
