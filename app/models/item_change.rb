class ItemChange < ApplicationRecord
    
    
    CHANGE_TYPES = {
        'request': 1,
        'donation': 2,
    }.freeze

    belongs_to :category
    belongs_to :request, optional: true

    validates :change_type, inclusion: { in: CHANGE_TYPES.values }

    validates_presence_of :quantity, :itemType, :size

    validates_numericality_of :quantity, greater_than: 0 

end
