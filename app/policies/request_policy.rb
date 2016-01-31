class RequestPolicy < ApplicationPolicy
     
  def update?
    edit?
  end
    
  def edit?
    editable
  end
  
  def cancel?
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
    if (record.organiser_id == user.id) && (record.cancel==false)
      return true
    else
      return false
    end
  end
  
  def editable
    if (record.organiser_id == user.id) && (record.date > Time.now.to_date)
      return true
    else
      return false
    end
  end
  
end
