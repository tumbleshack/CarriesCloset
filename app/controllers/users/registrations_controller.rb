class Users::RegistrationsController < Devise::RegistrationsController
  before_action :set_user, only: %i[ show edit update destroy ]

  def update
    @user.email_setting.preference = user_params[:email_setting_attributes][:preference] unless @user.nil? || user_params.nil? || user_params[:email_setting_attributes].nil? || user_params[:email_setting_attributes][:preference].nil?
    super
  end

  protected

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:email, :admin, :volunteer, :donee, :donor, :password, :current_password,
                                 :password_confirmation, email_setting_attributes: [:preference])
  end

end
