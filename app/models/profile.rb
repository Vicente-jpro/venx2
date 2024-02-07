class Profile < ApplicationRecord
  belongs_to :user
  belongs_to :address
  accepts_nested_attributes_for :address, allow_destroy: true

  has_many :items
  has_many :invoice_temps

  has_one_attached :image do |attachable|
    attachable.variant :thumb, resize_to_limit: [140, 140]
  end

  validates_presence_of :name_profile, :profile_type, :gender
  validates :whatsapp, :telephone, presence: true, uniqueness: true


  enum gender: { masculine: "MASCULINO", feminine: "FEMININO" }
  enum profile_type: {
    adminstrador: "ADMINSTRADOR212", 
    funcionario: "FUNCIONARIO"
  }
  
  def self.find_by_user(user) 
    Profile.find_by(user_id: user.id)
  end
  
end
