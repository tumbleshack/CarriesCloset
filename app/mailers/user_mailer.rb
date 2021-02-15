class UserMailer < ApplicationMailer
    def new_admin_urgent_email
        # UserMailer.with(user: User.first).welcome_email
        @request = params[:request]
        mail to: User.admins.pluck(:email), #send to all admins
          subject: "[URGENT] Donation Request" if User.admins.any? # only is admins exist
    end

    def new_email
        # UserMailer.with(user: User.first).welcome_email
        @request = params[:request]
        mail to: @request.email,
          subject: "Donation Request Confirmation"
    end
end
