class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Adds in several different ways to query all `User` objects. For example, to
  # get all users marked as administrators, you can use `User.admins`.

  scope :admins,     -> { where(admin:     1) }
  scope :volunteers, -> { where(volunteer: 1) }
  scope :donees,     -> { where(donee:     1) }
  scope :donors,     -> { where(donor:     1) }

end
