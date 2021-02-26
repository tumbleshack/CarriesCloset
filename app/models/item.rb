class Item < ApplicationRecord
  has_one :category
  
  validates_presence_of :quantity, :category, :itemType, :size

  validates_numericality_of :quantity, greater_than: -1, :message => "can't be negative"
end
