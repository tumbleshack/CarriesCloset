class Category < ApplicationRecord
  has_many :versions
  has_many :items, through: :versions

  validates :name, length: { minimum: 2 }
end
