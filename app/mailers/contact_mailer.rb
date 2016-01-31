class ContactMailer < ActionMailer::Base
  
  default from: 'no-reply@localhost.com'
    
  def contact_form(name, email, reason, comment)
    
    @name = name
    @email = email
    @reason = reason
    @comment = comment
      
    mail(to:"testuser@localhost.com", subject: 'Contact Form Submission')
  end
  
end
