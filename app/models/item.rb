class Item < ApplicationRecord
  
  CATEGORIES = {
    '': 0,
    'Boys': 1,
    'Girls': 2,
    'Womens': 3,
    'Mens': 4,
    'Hygeine Products': 5
  }.freeze
end
