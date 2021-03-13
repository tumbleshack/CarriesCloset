class Item < ApplicationRecord
  has_one :category
  
  validates_presence_of :quantity, :itemType, :size, :in_inventory, :in_request

  validates_numericality_of :quantity, greater_than: -1, :message => "can't be negative"

  belongs_to :request, optional: true

  def category
    Category.find(category_id)
  end

  def new
    @item = Item.new
  end

end
