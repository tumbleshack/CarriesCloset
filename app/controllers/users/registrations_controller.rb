class Users::RegistrationsController < Devise::RegistrationsController
  before_action :set_user, only: %i[ show edit update destroy ]

  protected

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:email, :admin, :volunteer, :donee, :donor, :password, :current_password,
                                 :password_confirmation, email_setting_attributes: [:preference])
  end

end
