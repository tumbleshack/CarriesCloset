class Item < ApplicationRecord
  
  validates_presence_of :quantity, :itemType, :size

  validate :has_place

  belongs_to :category

  def has_place
    unless in_inventory || in_request || in_donation
      errors[:base] << "The item must be assigned to at least one status."
    end
  end

  validates_numericality_of :quantity, greater_than: -1, :message => "can't be negative"

  belongs_to :request, optional: true
  # belongs_to :donation, optional: true

  def category
    Category.find(category_id)
  end
end
