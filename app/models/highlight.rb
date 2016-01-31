class Highlight < ActiveRecord::Base
  
  belongs_to :vendor
  
  validates_presence_of :title, :description
  
end
