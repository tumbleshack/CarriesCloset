class Item < ApplicationRecord
  has_many :versions
  has_many :categories, :through => :versions
  
  validates_presence_of :name
end
