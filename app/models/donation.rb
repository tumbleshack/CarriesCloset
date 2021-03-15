class Donation < ApplicationRecord

  validates_presence_of :full_name, :email, :availability,
                        :county, :meet, :phone, :items

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
