class ProposalPolicy < ApplicationPolicy
  
  def create?
    new?
  end
  
  def new?
    single_proposal
  end
  
  def update?
    edit?
  end
    
  def edit?
    owned
  end
  
     
  class Scope < Struct.new(:user, :scope)
    def resolve
      scope
    end
  end
  
  
  private
  
  def owned
    record.vendor_id == user.id
  end
  
  def single_proposal
    
    if !(Proposal.exists?(request_id: record.request_id,vendor_id: user.id))
      
      request = Request.find(record.request_id)
      
      if !(request.cancel?) && !(request.vendor_select?) && (request.date>Time.now.to_date) && (request.category_id==user.category_id)
        return true
      else
        return false
      end 
      
    end
    
  end
    
end
