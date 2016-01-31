class Proposal < ActiveRecord::Base
  
  belongs_to :request
  
  belongs_to :vendor
  
  validates_presence_of :price, :description
  
  validates_uniqueness_of :vendor_id, scope: :request_id, :message=>"you have already submitted proposal to this request. Edit your proposal to change it."
    
end
