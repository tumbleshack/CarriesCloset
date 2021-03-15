class ItemChange < ApplicationRecord
    enum types: [ :request, :donation ]

    belongs_to :category
    belongs_to :request, optional: true

    validates :type, inclusion: { in: types }

    validates_presence_of :quantity, :itemType, :size

    after_initialize :set_defaults, unless: :persisted?
  # The set_defaults will only work if the object is new

    def set_defaults
        self.type = :request
        self.category ||= Category.all.first
    end

    
end
