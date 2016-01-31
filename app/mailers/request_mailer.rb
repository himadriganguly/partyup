require 'mandrill' 

class RequestMailer < ActionMailer::Base
   
  def new_request(request, organiserName, vendorEmails)
    
    Rails.logger.info vendorEmails
    
    mandrill = Mandrill::API.new ENV['SMTP_PASSWORD']
    
    template_name = "new-request"
    
    template_content = [      
      {
        "name"=>"organiser_name",
        "content"=>organiserName
      },
      {
        "name"=>"request_category",
        "content"=>request.category.name
      },
      {
        "name"=>"request_link",
        "content"=>"<a href='http://www.localhost.com/requests/#{request.id}' style='text-decoration:none;color:#0098F8'>#{request.title.capitalize}</a>"
      },
      {
        "name"=>"request_budget",
        "content"=>"Rs "+request.budget.to_s
      }      
    ]
    message = {
      "subject"=> "New Request Posted",
      "from_email"=>"no-reply@localhost.com",
      "from_name"=>"PartyUp",
      "to"=>vendorEmails,
      "headers"=>{"Reply-To"=>"no-reply@localhost.com"},
      "tags"=>["organiser"],
    }
    
    result = mandrill.messages.send_template template_name, template_content, message
    
    Rails.logger.info result
    
    rescue Mandrill::Error => e
    # Mandrill errors are thrown as exceptions
    puts "A mandrill error occurred: #{e.class} - #{e.message}"
    # A mandrill error occurred: Mandrill::UnknownSubaccountError - No subaccount exists with the id 'customer-123'
    raise
    
  end
  
  def edit_request(request, organiserName, vendorEmails)
    
    Rails.logger.info vendorEmails
    
    mandrill = Mandrill::API.new ENV['SMTP_PASSWORD']
    
    template_name = "edit-request"
    
    template_content = [      
      {
        "name"=>"organiser_name",
        "content"=>organiserName
      },
      {
        "name"=>"request_category",
        "content"=>request.category.name
      },
      {
        "name"=>"request_title",
        "content"=>request.title
      },
      {
        "name"=>"request_link",
        "content"=>"<a href='http://www.localhost.com/requests/#{request.id}' style='text-decoration:none;color:#0098F8'>#{request.title}</a>"
      },
      {
        "name"=>"request_budget",
        "content"=>"Rs "+request.budget.to_s
      }      
    ]
    message = {
      "subject"=> "Request Edited",
      "from_email"=>"no-reply@localhost.com",
      "from_name"=>"PartyUp",
      "to"=>vendorEmails,
      "headers"=>{"Reply-To"=>"no-reply@localhost.com"},
      "tags"=>["organiser"],
    }
    
    result = mandrill.messages.send_template template_name, template_content, message
    
    Rails.logger.info result
    
    rescue Mandrill::Error => e
    # Mandrill errors are thrown as exceptions
    puts "A mandrill error occurred: #{e.class} - #{e.message}"
    # A mandrill error occurred: Mandrill::UnknownSubaccountError - No subaccount exists with the id 'customer-123'
    raise
    
  end
  
  
  
  def vendor_invite(request, organiserName, vendor, email)
    
    Rails.logger.info email
    
    mandrill = Mandrill::API.new ENV['SMTP_PASSWORD']
    
    template_name = "vendor-invite"
    
    template_content = [      
      {
        "name"=>"orgniser_name",
        "content"=>organiserName
      },
      {
        "name"=>"request_title",
        "content"=>request.title.capitalize
      },
      {
        "name"=>"request_link",
        "content"=>"<a href='http://www.localhost.com/requests/#{request.id}' style='text-decoration:none;color:#0098F8'>#{request.title.capitalize}</a>"
      },
      {
        "name"=>"request_budget",
        "content"=>"Rs "+request.budget.to_s
      }      
    ]
    message = {
      "subject"=> "Invitation to Submit Proposal",
      "from_email"=>"no-reply@localhost.com",
      "from_name"=>"PartyUp",
      "to"=>email,
      "headers"=>{"Reply-To"=>"no-reply@localhost.com"},
      "tags"=>["organiser"],
    }
    
    result = mandrill.messages.send_template template_name, template_content, message
    
    Rails.logger.info result
    
    rescue Mandrill::Error => e
    # Mandrill errors are thrown as exceptions
    puts "A mandrill error occurred: #{e.class} - #{e.message}"
    # A mandrill error occurred: Mandrill::UnknownSubaccountError - No subaccount exists with the id 'customer-123'
    raise
    
  end
  
  def award_request(request, organiser, organiserName, vendorEmail, proposalPrice)
    
    Rails.logger.info vendorEmail
    
    mandrill = Mandrill::API.new ENV['SMTP_PASSWORD']
    
    template_name = "award-vendor"
    
    template_content = [      
      {
        "name"=>"request_title",
        "content"=>request.title
      },
      {
        "name"=>"orgniser_name",
        "content"=>organiserName
      },
      {
        "name"=>"orgniser_email",
        "content"=>organiser.email
      },
      {
        "name"=>"orgniser_mobile",
        "content"=>organiser.mobile
      },
      {
        "name"=>"request_link",
        "content"=>"<a href='http://www.localhost.com/requests/#{request.id}' style='text-decoration:none;color:#0098F8'>#{request.title.capitalize}</a>"
      },
      {
        "name"=>"proposed_price",
        "content"=>"Rs "+proposalPrice.to_s
      }      
    ]
    message = {
      "subject"=> "Proposal Awarded",
      "from_email"=>"no-reply@localhosts.com",
      "from_name"=>"PartyUp",
      "to"=>vendorEmail,
      "headers"=>{"Reply-To"=>"no-reply@localhost.com"},
      "tags"=>["organiser"],
    }
    
    result = mandrill.messages.send_template template_name, template_content, message
    
    Rails.logger.info result
    
    rescue Mandrill::Error => e
    # Mandrill errors are thrown as exceptions
    puts "A mandrill error occurred: #{e.class} - #{e.message}"
    # A mandrill error occurred: Mandrill::UnknownSubaccountError - No subaccount exists with the id 'customer-123'
    raise
    
  end
  
  def vendor_details(request, vendor, vendorName, organiserEmail, proposalPrice)
    
    Rails.logger.info organiserEmail
    
    mandrill = Mandrill::API.new ENV['SMTP_PASSWORD']
    
    template_name = "vendor-details"
    
    template_content = [      
      {
        "name"=>"request_title",
        "content"=>request.title
      },
      {
        "name"=>"vendor_name",
        "content"=>vendorName
      },
      {
        "name"=>"vendor_email",
        "content"=>vendor.email
      },
      {
        "name"=>"vendor_mobile",
        "content"=>vendor.mobile
      },
      {
        "name"=>"request_link",
        "content"=>"<a href='http://www.localhost.com/requests/#{request.id}' style='text-decoration:none;color:#0098F8'>#{request.title.capitalize}</a>"
      },
      {
        "name"=>"proposed_price",
        "content"=>"Rs "+proposalPrice.to_s
      }      
    ]
    message = {
      "subject"=> "Proposal Awarded",
      "from_email"=>"no-reply@localhost.com",
      "from_name"=>"PartyUp",
      "to"=>organiserEmail,
      "headers"=>{"Reply-To"=>"no-reply@localhost.com"},
      "tags"=>["organiser"],
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
