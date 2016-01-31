# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "YOUR DOMAIN NAME"
#SitemapGenerator::Sitemap.sitemaps_path = 'sitemaps/'

SitemapGenerator::Sitemap.create do
  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically for you.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  #
  # Examples:
  #
  # Add '/articles'
  #
  #   add articles_path, :priority => 0.7, :changefreq => 'daily'
  #
  # Add all articles:
  #
  #   Article.find_each do |article|
  #     add article_path(article), :lastmod => article.updated_at
  #   end
  
  add '/contact', :changefreq => 'weekly'
    
  Organiser.find_each do |organiser|
    add organiser_details_path(organiser.username), :lastmod => organiser.updated_at, :changefreq => 'daily'
  end
  
  Request.find_each do |request|
    add request_path(request), :lastmod => request.updated_at, :changefreq => 'daily'
  end
  
  Vendor.find_each do |vendor|
    add vendor_details_path(vendor.username), :lastmod => vendor.updated_at, :changefreq => 'daily'
  end
  
end

#SitemapGenerator::Sitemap.ping_search_engines # Not needed if you use the rake tasks
