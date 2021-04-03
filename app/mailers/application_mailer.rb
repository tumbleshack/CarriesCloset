class ApplicationMailer < ActionMailer::Base
  #"SenderName <hola@udocz.com>"
  default from: "Carrie's Closet of GA <carries.closet.confirmations@gmail.com>"
  #default from: 'carries.closet.confirmations@gmail.com'
  layout 'mailer'
end
