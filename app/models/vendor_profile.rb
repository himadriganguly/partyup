class VendorProfile < ActiveRecord::Base
  
  belongs_to :vendor 
  
  has_attached_file :pic1,                    
                    :styles       => { :medium => "800x504" }    
                    
  validates_attachment :pic1,
                       :content_type => { :content_type => ["image/jpg", "image/jpeg", "image/png"] },
                       :size => { :in => 99.kilobytes..501.kilobytes, :message => "must be in between 100KB and 500KB" }
                                              
  validates_attachment_content_type :pic1, :content_type => /\Aimage/  
  
  has_attached_file :pic2,
                    :styles       => { :medium => "800x504" }
                    
  validates_attachment :pic2,
                       :content_type => { :content_type => ["image/jpg", "image/jpeg", "image/png"] },
                       :size => { :in => 99.kilobytes..501.kilobytes, :message => "must be in between 100KB and 500KB" }                       
  
  validates_attachment_content_type :pic2, :content_type => /\Aimage/  
  
  has_attached_file :pic3,
                    :styles       => { :medium => "800x504" }
                    
  validates_attachment :pic3,
                       :content_type => { :content_type => ["image/jpg", "image/jpeg", "image/png"] },
                       :size => { :in => 99.kilobytes..501.kilobytes, :message => "must be in between 100KB and 500KB" }                       
  
  validates_attachment_content_type :pic3, :content_type => /\Aimage/  
  
  has_attached_file :pic4,
                    :styles       => { :medium => "800x504" }                     
                   
  validates_attachment :pic4,
                       :content_type => { :content_type => ["image/jpg", "image/jpeg", "image/png"] },
                       :size => { :in => 99.kilobytes..501.kilobytes, :message => "must be in between 100KB and 500KB" }                       
  
  validates_attachment_content_type :pic4, :content_type => /\Aimage/  
                      
end