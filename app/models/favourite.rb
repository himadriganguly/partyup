class Favourite < ActiveRecord::Base
  
  belongs_to :request
  
  belongs_to :vendor
  
end
