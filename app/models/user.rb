class User < ApplicationRecord

  before_validation :ensure_email_setting


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  include DeviseInvitable::Inviter

  # Adds in several different ways to query all `User` objects. For example, to
  # get all users marked as administrators, you can use `User.admins`.

  scope :admins,     -> { where(admin:     1) }
  scope :volunteers, -> { where(volunteer: 1) }
  scope :donees,     -> { where(donee:     1) }
  scope :donors,     -> { where(donor:     1) }


  has_one :email_setting, dependent: :destroy, required: true
  accepts_nested_attributes_for :email_setting

  def ensure_email_setting
    self.build_email_setting.save! if self.email_setting.nil?
  end


end
