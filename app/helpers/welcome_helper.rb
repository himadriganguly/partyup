module WelcomeHelper
  require 'uri'
  
  def extract_youtube_id(link)
    query_string = URI.parse(link).query
    parameters = Hash[URI.decode_www_form(query_string)]
    return parameters['v'] # => aNdMiIAlK0g    
  end
  
end
