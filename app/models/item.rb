class Item < ApplicationRecord
  validates_presence_of :quantity, :itemType, :size

  belongs_to :category


  validates_numericality_of :quantity, greater_than: -1, :message => "can't be negative"

  def category
    Category.find(category_id)
  end
end
