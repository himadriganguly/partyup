class AddConfirmableLockableToOrganiser < ActiveRecord::Migration
  
  def change
    
    ## Confirmable
    add_column :organisers, :confirmation_token, :string
    add_column :organisers, :confirmed_at, :datetime
    add_column :organisers, :confirmation_sent_at, :datetime
    add_column :organisers, :unconfirmed_email, :string # Only if using reconfirmable
    
     ## Lockable
     add_column :organisers, :failed_attempts, :integer, default: 0, null: false # Only if lock strategy is :failed_attempts
     add_column :organisers, :unlock_token, :string # Only if unlock strategy is :email or :both
     add_column :organisers, :locked_at, :datetime
     
     add_index :organisers, :confirmation_token,   unique: true
     add_index :organisers, :unlock_token,         unique: true
        
  end
  
end
