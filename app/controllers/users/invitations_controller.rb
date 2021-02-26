class Users::InvitationsController < Devise::InvitationsController
    before_action -> { require_role(:root, :admin) }, only: [:new, :create]
    before_action :configure_permitted_parameters

    protected

    def configure_permitted_parameters
        puts "params configured"
        devise_parameter_sanitizer.permit(:invite, keys: [:admin, :volunteer, :donor, :donee])
        # devise_parameter_sanitizer.permit(:accept_invitation, keys: [:admin, :volunteer, :donor, :donee])
    end
end