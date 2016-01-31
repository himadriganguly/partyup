require 'mandrill'

class ClarificationMailer < ActionMailer::Base
  
  def new_clarification(clarifierName, clarifierClass, clarificationNumber, request, emails)
    
    Rails.logger.info emails
    
    mandrill = Mandrill::API.new ENV['SMTP_PASSWORD']
    
    template_name = "new-clarification"
    
    template_content = [      
      {
        "name"=>"clarifier_name",
        "content"=>"#{clarifierName} (#{clarifierClass})"
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
        "name"=>"clarification_number",
        "content"=>clarificationNumber
      }      
    ]
    message = {
      "subject"=> "New Clarification Posted",
      "from_email"=>"no-reply@localhost.com",
      "from_name"=>"PartyUp",
      "to"=>emails,
      "headers"=>{"Reply-To"=>"no-reply@localhost.com"},
      "tags"=>["clarification"],
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
