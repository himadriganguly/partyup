class FavouritePolicy < ApplicationPolicy
    
  def destroy?
    owned
  end
  
  class Scope < Struct.new(:user, :scope)
    def resolve
      scope
    end
  end
  
  
  private
  
  def owned
    Favourite.exists?(vendor_id: user.id, request_id: record.request_id)
  end
  
end
