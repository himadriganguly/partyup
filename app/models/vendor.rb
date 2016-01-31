class Vendor < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :lockable  
  
  scope :unconfirmed, -> { where(confirmed_at: nil) }
  
  # Creation of Vendor Profile after Vendor Registration
  after_create :create_profile
  
  # Vendor belongs to a City
  belongs_to :city
  
  # Vendor belongs to a Category
  belongs_to :category
  
  # Vendor has only on Profile       
  has_one :vendor_profile, dependent: :destroy  
  accepts_nested_attributes_for :vendor_profile
  
  # Vendor can create many highlights
  has_many :highlights, dependent: :destroy
  
  # Vendor can have many Reviews
  has_many :vendor_reviews, dependent: :destroy    
  
  # Checks the validation on Vendor before saving the data to the database  
  validates_presence_of :first_name,:last_name,:business_name,:est_year,:category,:city_id,:username,:mobile
  
  # Validates the uniquess of username for Vendor
  validates_uniqueness_of :username
  
  # ****** Proposals Relation ******
  
  # Vendor can have proposal in many Requests
  
  has_many :proposals, dependent: :destroy  
  
  # ****** End of Proposals Relation ******
  
  # ****** Clarifications Relation (Polymorphic Association) ******
  
  has_many :clarifications, as: :clarify
  
  # ****** End of Clarifications Relation ******
  
  # ****** Favourites Relation ******
  
  has_many :favourites, dependent: :destroy
  
  has_many :requests, through: :favourites
  
  # ****** End of Favourites Relation ******
  
  
  has_attached_file :avatar,
                    :default_url  => "/avatars/default/:style/missing.png",
                    :styles       => { :thumb => "100x100" }    
                 
  validates_attachment :avatar,
                       :content_type => { :content_type => ["image/jpg", "image/jpeg", "image/png"] },
                       :size => { :in => 9.kilobytes..51.kilobytes, :message => "must be in between 10KB and 50KB" }
                       
  validates_attachment_content_type :avatar, :content_type => /\Aimage/  
  
  
  def active_for_authentication? 
    super && approved? 
  end 
  
  def inactive_message 
    if !approved? 
      :not_approved 
    else 
      super # Use whatever other message 
    end 
  end
  
  private
  
  def create_profile
    profile = VendorProfile.new()
    profile.vendor_id = self.id
    profile.save
  end
  
  
end
