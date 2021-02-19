class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Adds in several different ways to query all `User` objects. For example, to
  # get all users marked as administrators, you can use `User.admins`.
  scope :admins,     -> { where(admin:     true) }
  scope :volunteers, -> { where(volunteer: true) }
  scope :donees,     -> { where(donee:     true) }
  scope :donors,     -> { where(donor:     true) }
end
