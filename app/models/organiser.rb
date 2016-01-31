class Organiser < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :lockable
  
  scope :unconfirmed, -> { where(confirmed_at: nil) }
  
  before_save :change_case
              
  belongs_to :city
  
  has_many :requests, dependent: :destroy
  
  # ****** Clarifications Relation (Polymorphic Association) ******
  
  has_many :clarifications, as: :clarify
  
  # ****** End of Clarifications Relation ******
  
  validates_presence_of :first_name,:last_name,:username,:mobile
  
  validates_uniqueness_of :username
  
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
  
  def change_case
    first_name.capitalize!
    last_name.capitalize!
    username.downcase!
  end
  
  
end
