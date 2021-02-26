class Item < ApplicationRecord
  has_one :category
  
  validates_presence_of :quantity, :itemType, :size

  validates_numericality_of :quantity, greater_than: -1, :message => "can't be negative"
  
  validates_uniqueness_of :itemType, :scope => [:category, :size]

  def category
    Category.find(category_id)
  end
end
