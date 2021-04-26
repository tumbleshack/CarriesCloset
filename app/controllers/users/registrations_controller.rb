class Users::RegistrationsController < Devise::RegistrationsController
  before_action :set_user, only: %i[ show edit update destroy ]
  before_action :create_email_settings, only: :edit

  def update
    attrs = user_params[:email_setting_attributes]
    @user.email_setting.preference = attrs[:preference] unless attrs.nil? || @user.email_setting.nil?
    super
  end

  protected

  def create_email_settings
    if !@user.nil? && @user.email_setting.nil?
      @user.build_email_setting(preference: :'All Urgent Requests').save!
    end
  end

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:email, :admin, :volunteer, :donee, :donor, :password, :current_password,
                                 :password_confirmation, email_setting_attributes: [:preference])
  end

end
