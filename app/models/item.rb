class Item < ApplicationRecord
  has_many :versions
  has_many :categories, :through => :versions
  
  validates_presence_of :name

  def for_category category
    versions.where(category: category).first
  end

  def category_named name
    versions.find_by(category: Category.find_by_name(name))
  end
end
