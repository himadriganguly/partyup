class Request < ActiveRecord::Base
  
  scope :requests_cancel, -> { where(cancel: true) }
  
  belongs_to :organiser
  
  belongs_to :city
  
  belongs_to :category
  
  # ****** Proposals Relation ******
  
  has_many :proposals, dependent: :destroy  
  
  has_many :vendors, through: :proposals
  
  # ****** End of Proposals Relation ******
  
  # ****** Clarifications Relation ******
  
  has_many :clarifications, dependent: :destroy
  
  # ****** End of Clarifications Relation ******
  
  # ****** Favourites Relation ******
  
  has_many :favourites, dependent: :destroy
  
  # ****** End of Favourites Relation ******
  
  validates_presence_of :title,:city_id,:venue,:category,:hours,:budget,:guests,:date, :time,:description
  
end
