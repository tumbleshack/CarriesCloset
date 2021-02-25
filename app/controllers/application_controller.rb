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
end
