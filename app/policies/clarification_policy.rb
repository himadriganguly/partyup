class ClarificationPolicy < ApplicationPolicy
   
  def update?
    edit?
  end
    
  def edit?
    owned
  end
  
  def destroy?
    delete?
  end
  
  def delete?
    owned
  end
  
  def create?
    new?
  end
  
  def new?
    proposal_posted
  end
  
  class Scope < Struct.new(:user, :scope)
    def resolve
      
    end
  end
  
  
  private 
  
  def owned
     
     Clarification.exists?(id: record.id, clarify_id: user.id, clarify_type: user.class)
  
  end
  
  def proposal_posted
    
   
      if Proposal.exists?(request_id: record.request_id, vendor_id: user.id ) || ( (Request.exists?(id: record.request_id, organiser_id: user.id)) && (Clarification.where("request_id=?",record.request_id).count>0) )
        
        request = Request.find(record.request_id)
        
        if !(request.cancel?) && !(request.vendor_select?) && (request.date>Time.now.to_date)
          return true
        end 
      
      # elsif Request.exists?(id: record.request_id, organiser_id: user.id)
#        
        # return true       
         
      end   
          
  end
  
end
