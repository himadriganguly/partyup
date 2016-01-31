class ContactsController < ApplicationController
  
  def new
    
    if organiser_signed_in?
      @email = current_organiser.email
      @name = full_name_object(current_organiser)
    elsif vendor_signed_in?
      @email = current_vendor.email
      @name = full_name_object(current_vendor)
    end

    @contact = Contact.new
    
    if (params[:reason]=="BetaFeedback")
      @reason = ContactReason.where("reason='Beta Feedback'").first       
    else
      @reason = ContactReason.where("reason='Customer Support Request'").first
    end
        
    @reason = @reason.id
        
  end
  
  def create
    
    @contact = Contact.new(contact_params)

    if @contact.save
      
      @name = @contact.name
      @email = @contact.email
      @reason = @contact.contact_reason.reason
      @comment = @contact.comment
            
      ContactMailer.contact_form(@name,@email,@reason,@comment).deliver
      
      flash[:notice] = "Contact Form submitted successfully. Thanks for contacting us."
      redirect_to :back
    else
      render('new')
    end    
    
  end
  
  private
  
  def contact_params
    params.require(:contact).permit(:name, :email, :comment, :contact_reason_id )    
  end
  
  
end
