require 'mandrill'

class ProposalMailer < ActionMailer::Base
  
  def new_proposal(request, vendor, vendorName, organiserEmail, price)
    
    Rails.logger.info organiserEmail
    
    mandrill = Mandrill::API.new ENV['SMTP_PASSWORD']
    
    template_name = "new-proposal"
    
    template_content = [      
      {
        "name"=>"vendor_name",
        "content"=>vendorName
      },
      {
        "name"=>"vendor_business_name",
        "content"=>vendor.business_name
      },
      {
        "name"=>"request_link",
        "content"=>"<a href='http://www.localhost.com/requests/#{request.id}' style='text-decoration:none;color:#0098F8'>#{request.title.capitalize}</a>"
      },
      {
        "name"=>"proposed_price",
        "content"=>"Rs "+price.to_s
      }      
    ]
    message = {
      "subject"=> "New Proposal Submitted",
      "from_email"=>"no-reply@localhost.com",
      "from_name"=>"PartyUp",
      "to"=>organiserEmail,
      "headers"=>{"Reply-To"=>"no-reply@localhost.com"},
      "tags"=>["vendor"],
    }
    
    result = mandrill.messages.send_template template_name, template_content, message
    
    Rails.logger.info result
    
    rescue Mandrill::Error => e
    # Mandrill errors are thrown as exceptions
    puts "A mandrill error occurred: #{e.class} - #{e.message}"
    # A mandrill error occurred: Mandrill::UnknownSubaccountError - No subaccount exists with the id 'customer-123'
    raise
    
  end
  
  def edit_proposal(request, vendor, vendorName, organiserEmail, price)
    
    Rails.logger.info organiserEmail
    
    mandrill = Mandrill::API.new ENV['SMTP_PASSWORD']
    
    template_name = "edit-proposal"
    
    template_content = [      
      {
        "name"=>"vendor_name",
        "content"=>vendorName
      },
      {
        "name"=>"vendor_business_name",
        "content"=>vendor.business_name
      },
      {
        "name"=>"request_link",
        "content"=>"<a href='http://www.localhost.com/requests/#{request.id}' style='text-decoration:none;color:#0098F8'>#{request.title.capitalize}</a>"
      },
      {
        "name"=>"proposed_price",
        "content"=>"Rs "+price.to_s
      }      
    ]
    message = {
      "subject"=> "Proposal Edited",
      "from_email"=>"no-reply@localhost.com",
      "from_name"=>"PartyUp",
      "to"=>organiserEmail,
      "headers"=>{"Reply-To"=>"no-reply@localhost.com"},
      "tags"=>["vendor"],
    }
    
    result = mandrill.messages.send_template template_name, template_content, message
    
    Rails.logger.info result
    
    rescue Mandrill::Error => e
    # Mandrill errors are thrown as exceptions
    puts "A mandrill error occurred: #{e.class} - #{e.message}"
    # A mandrill error occurred: Mandrill::UnknownSubaccountError - No subaccount exists with the id 'customer-123'
    raise
    
  end
  
  
end
