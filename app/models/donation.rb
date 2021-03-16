class Donation < ApplicationRecord

  has_many :item_changes
  accepts_nested_attributes_for :item_changes, allow_destroy: true
  
  validates_presence_of :full_name, :email, :availability,
                        :county, :meet, :phone, :item_changes

  validates_numericality_of :county, greater_than: 0, :message => "can't be blank"
  
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  
  validates :phone, phone: true

  validates :address,
            presence: true,
            length: { in: 7..200 },
            if: Proc.new { |a| a.meet == 2}

  validates :full_name,
            length: { in: 2..80 }


  
end
