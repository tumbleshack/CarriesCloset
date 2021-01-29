class Request < ApplicationRecord
  URGENCIES = {
    '': 0,
    'Within 24 hours': 1
  }.freeze

  RELATIONSHIPS = {
    '': 0,
    'Foster Child': 1
  }.freeze

  COUNTIES = {
    '': 0,
    'Fulton': 1
  }.freeze

  validates_presence_of :relationship, :full_name, :urgency, :email, :availability,
                        :county, :meet, :phone

  validates_length_of :urgency, :relationship, :county, minimum: 1

  validates :address,
            presence: true,
            length: { in: 7..200 },
            if: Proc.new { |a| a.meet == 1 }

  validates :full_name,
            length: { in: 2..80 }
end
