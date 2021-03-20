class Users::RegistrationsController < Devise::RegistrationsController
  before_action :set_user, only: %i[ show edit update destroy ]

  def update
    @user.build_email_setting.save! if @user.email_setting.nil?
    @user.email_setting.update(preference: user_params['email_setting_attributes']['preference'])
    
    super
  end
  
  protected

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:email, :admin, :volunteer, :donee, :donor, :current_password,
                                 :password_confirmation => [], email_setting_attributes: [:preference])
  end
end
