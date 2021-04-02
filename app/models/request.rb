class Request < ApplicationRecord

  URGENCIES = {
    '': 0,
    'Within 24 hours': 1,
    'Within 48 hours': 2,
    'Within a week': 3,
  }.freeze

  RELATIONSHIPS = {
    '': 0,
    'Foster Child': 1,
    'Juvenile Detention Center': 2,
    'Domestic Violence Center': 3,
    'Homeless Youth': 4,
    'Refugee/Displaced Person': 5,
  }.freeze

  COUNTIES = {
    '': 0,
    'Fulton': 1,
    'Dekalb': 2,
    'Gwinnett': 3,
    'Cobb': 4,
    'Clayton': 5,
    'Henry': 6,
    'Muscogee': 7,
    'Other (provide your address below)': 8
  }.freeze

  has_many :item_changes
  accepts_nested_attributes_for :item_changes, allow_destroy: true

  has_many :cart_items, class_name: 'ItemChange', through: :item_changes

  def any_blank(att)
    att.any? { |k, v| v.blank? }
  end

  validates_presence_of :relationship, :full_name, :urgency, :email, :availability,
                        :county, :meet, :phone, :item_changes

  validates_numericality_of :urgency, :relationship, :county, greater_than: 0, :message => "can't be blank"
  
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  
  validates :phone, phone: true

  validates :address,
            presence: true,
            length: { in: 7..200 },
            if: Proc.new { |a| a.meet == 2}

  validates :full_name,
            length: { in: 2..80 }
            
end
