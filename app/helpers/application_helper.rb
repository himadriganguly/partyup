module ApplicationHelper
  
  def error_messages_for(object)
    render(:partial => 'layouts/error_messages', :locals => {:object => object})
  end
  
  def full_name_object(object)
    return object.first_name + " " + object.last_name
  end
  
  def rating_star(object)
    star = ""
    if object==5
      5.times do
        star +=  "<i class='fa fa-star'></i> " 
      end
    else
      rem = 5-object
      object.times do
        star += "<i class='fa fa-star'></i> "
      end
      rem.times do
        star += "<i class='fa fa-star empty'></i> "
      end
    end
    return star        
  end
  
  def sanitized_data(data,tags=[])
    tags = %w(b i strong em p br ol ul li h1 h2 h3 h4 h5 h6 blockquote u a span div small) - tags
    return sanitize data, tags: tags, attributes: %w(rel target href title)
  end
  
  def nav_link(link_text, link_path)
    class_name = current_page?(link_path) ? 'active' : ''
  
    content_tag(:li, :class => class_name) do
      link_to link_text, link_path
    end
  end
      
end
