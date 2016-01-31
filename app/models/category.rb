class Category < ActiveRecord::Base
  
  has_many :vendors
  
  has_many :requests
  
end
