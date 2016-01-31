class Clarification < ActiveRecord::Base
  
  belongs_to :request
  
  belongs_to :clarify, polymorphic: true
  
end
