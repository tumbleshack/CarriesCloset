class UserMailer < ApplicationMailer
    def new_admin_urgent_email
        # UserMailer.with(user: User.first).welcome_email
        @request = params[:request]
        # mail to: User.admins.pluck(:email), #send to all admins
        #   subject: "[URGENT] Donation Request" if User.admins.any? # only is admins exist
        if User.admins.any?
          mail to: User.admins.pluck(:email), #send to all admins
           subject: "[URGENT] Donation Request"
        else 
          mail to: 'carries.closet.confirmations@gmail.com', #send to all ccarries closet email if no admins
           subject: "[URGENT] Donation Request"
        end
        
      
        
    end

    def new_email
        # UserMailer.with(user: User.first).welcome_email
        @request = params[:request]
        mail to: @request.email,
          subject: "Donation Request Confirmation"
    end

    def new_donor_email
      @donation = params[:donation]
        mail to: "@donation.email",
          subject: "Donation Confirmation"
    end
end
