class ApplicationController < ActionController::Base
  # Basic authorization available to all controllers, allowing for fine-tuned
  # access limitation based on defined User roles. To protect a Controller
  # method, add something like the following to the top of the Controller:
  #
  #   before_action -> { require_roles(:root, :admin) }, only: :index
  #
  # Here, the user's roles will only be checked when the visit the `index`
  # route on the controller, e.g. `/requests`. If the user fails the check,
  # they will be redirected to `:root`, the home route of the project. Finally,
  # we configure that only users with `admin` abilities should be able to
  # access the protected `index` route.
  def require_role(redirect_path, role)
    should_reject = false
    case role
      when :admin;     should_reject = true unless (current_user != nil and current_user.admin?)
      when :volunteer; should_reject = true unless (current_user != nil and current_user.volunteer?)
      when :donee;     should_reject = true unless (current_user != nil and current_user.donee?)
      when :donor;     should_reject = true unless (current_user != nil and current_user.donor?)
    end

    redirect_to redirect_path, alert: 'You do not have proper authorization to access the attempted URL.' if should_reject
  end

  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  protected

  def configure_permitted_parameters
      #devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:name, :email, :password) }
      devise_parameter_sanitizer.permit(:account_update, keys: [:email, :password, :current_password, :admin, :volunteer, :donor, :donee])
  end
end
