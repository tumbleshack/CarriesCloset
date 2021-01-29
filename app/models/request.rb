class Request < ApplicationRecord
  validates_presence_of :type, :full_name, :urgency, :email, :availability,
                        :county, :meet, :phone

  validates :full_name,
            length: { in: 2..80 }
end
