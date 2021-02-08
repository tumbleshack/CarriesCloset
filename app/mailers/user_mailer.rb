class UserMailer < ApplicationMailer
    def new_admin_urgent_email
        # UserMailer.with(user: User.first).welcome_email
        @request = params[:request]
        mail to: ENV[ADMIN_EMAIL],
          subject: "[URGENT] Donation Request"
    end

    def new_email
        # UserMailer.with(user: User.first).welcome_email
        @request = params[:request]
        mail to: @request.email,
          subject: "Donation Request Confirmation"
    end
end
