class ProposalsController < ApplicationController
 
  before_filter :authenticate_vendor!, except: [:award]
  
  after_action :verify_authorized, only: [:new, :create, :edit, :update]
   
  def new
        
    if Request.exists?(params[:id])
           
      @proposal = Proposal.new
      @proposal.request_id = params[:id]
      authorize @proposal
      
      @request = Request.find(params[:id])
      
    else
      flash[:error] = "Sorry the request doesn't exits where you want to submit the proposal."
      redirect_to(:controller=>"dashboard/requests",:action => 'index')
    end
        
  end
  
  def create      
    
    if Request.exists?(params[:request_id])
      
      @proposal = Proposal.new(proposal_params)
      @proposal.request_id = params[:request_id]
      authorize @proposal
            
      @proposal.vendor = current_vendor    
      
      if @proposal.save
        
        request = @proposal.request
        vendor = @proposal.vendor
        
        email = [{"email"=>request.organiser.email,"name"=>full_name_object(request.organiser),"type"=>"to"}]
      
        ProposalMailer.new_proposal(request, vendor, full_name_object(vendor), email, @proposal.price).deliver
        
        flash[:notice] = "Proposal has been posted successfully."
        redirect_to request_path(@proposal.request_id)
      else        
        @request = Request.find(params[:request_id])        
        render('new')
      end   
      
    else
      flash[:error] = "Sorry the request doesn't exits where you want to submit the proposal."
      redirect_to(:controller=>"dashboard/requests",:action => 'index')
    end   
        
  end
  
  def edit  
    
    @proposal = Proposal.find(params[:id])
    authorize @proposal
    
    @request = @proposal.request
          
  end
  
  def update
    
    @proposal = Proposal.find(params[:id])
    authorize @proposal
    
    if @proposal.update_attributes(proposal_params)
      
      request = @proposal.request
      vendor = @proposal.vendor
        
      email = [{"email"=>request.organiser.email,"name"=>full_name_object(request.organiser),"type"=>"to"}]
      
      ProposalMailer.edit_proposal(request, vendor, full_name_object(vendor), email, @proposal.price).deliver
      
      flash[:notice] = "Proposal updated successfully."
      redirect_to("/requests/#{@proposal.request_id}")
    else      
      render('edit')
    end
    
  end
  
  def award
    
      @proposal = Proposal.find(params[:id])  
      
      if organiser_signed_in? && (@proposal.request.organiser_id == current_organiser.id)     
          
        if !(@proposal.is_winner?) && @proposal.update_attributes(:is_winner=>true)
          @request = Request.find(@proposal.request_id)
          
          if !(@request.vendor_select?) && @request.update_attributes(:vendor_select=>true)
            
            organiser = @request.organiser
            vendor = @proposal.vendor
            
            organiserName = full_name_object(organiser)
            vendorName = full_name_object(vendor)
            
            vendorEmail = [{"email"=>@proposal.vendor.email,"name"=>full_name_object(@proposal.vendor),"type"=>"to"}]
            organiserEmail = [{"email"=>organiser.email,"name"=>full_name_object(organiser),"type"=>"to"}]
            
            RequestMailer.award_request(@request, organiser, organiserName, vendorEmail, @proposal.price).deliver
            RequestMailer.vendor_details(@request, vendor, vendorName, organiserEmail, @proposal.price).deliver
            
            respond_to do |format|
              format.html {
                session[:award_success] = "<center>The Request has been awarded to <strong>#{full_name_object(@proposal.vendor)}</strong> of <strong>#{@proposal.vendor.business_name}</strong>.<br /><br />The vendor has been informed about your award and they will contact you soon.<br /><br /><span class='glyphicon glyphicon-heart'></span> Thanks for using our service wish you all the best for your event.</center>"
                redirect_to :back
              }
            end
          else
            respond_to do |format| 
              format.html {
                flash[:error] = "Vendor has already been selected for the request.You cannot select it again."
                redirect_to :back
              }
            end 
          end
          
        else  
          respond_to do |format| 
            format.html {
              flash[:error] = "Some errors prevent awarding the project to the vendor"
              redirect_to :back
            }
          end 
        end
      
      else
        render :file => "#{Rails.root}/public/404.html",  :status => 404
      end   
     
  end
  
  
  private
  
  def proposal_params
    params.require(:proposal).permit(:price, :description)    
  end
  
  def pundit_user  
    current_vendor 
  end
  
end
