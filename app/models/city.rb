class City < ActiveRecord::Base
  
  has_many :vendors
  
  has_many :organisers
  
  has_many :requests
  
  def display_name
    name.upcase
  end
  
end
