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

    def volunteer_email
      @request = params[:request]
      volunteer_emails = Array.new
      count = 0
      if User.volunteers.any?
        volunteers = User.volunteers.pluck(:email)
        for x in User.volunteers do 
          if x.email_setting.send_all?
            volunteer_emails[count] = x.email
            count = count + 1
          end  
        end
      end
      
      if volunteer_emails.length() > 0
        mail to: volunteer_emails, #send to all admins
            subject: "Donation Request Notification"
      else 
        mail to: 'carries.closet.confirmations@gmail.com', #send to all ccarries closet email if no admins
          subject: "Donation Request Notification"
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
        mail to: @donation.email,
          subject: "Donation Confirmation"
    end

end
