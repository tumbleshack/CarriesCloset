class Item < ApplicationRecord
  
  CATEGORIES = {
    '': 0,
    'Boys': 1,
    'Girls': 2,
    'Womens': 3,
    'Mens': 4,
    'Hygeine Products': 5
  }.freeze
  
  validates_presence_of :quantity, :category, :itemType, :size

  validates_numericality_of :quantity, greater_than: -1, :message => "can't be negative"
end
