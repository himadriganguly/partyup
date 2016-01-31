class Contact < ActiveRecord::Base
  
  scope :not_replied, -> { where(replied: false) }
  
  belongs_to :contact_reason
  
  validates_presence_of :name, :email, :contact_reason, :comment
  
end
