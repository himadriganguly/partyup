class HighlightPolicy < ApplicationPolicy
  
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
  
  class Scope < Struct.new(:user, :scope)
    
    def resolve
      scope
    end
    
  end
  
  
  private
  
  def owned
    record.vendor_id == user.id
  end
  
end
