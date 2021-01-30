# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
    def new_email
        # Set up a temporary order for the preview
        #order = Order.new(name: "Joe Smith", email: "joe@gmail.com", address: "1-2-3 Chuo, Tokyo, 333-0000", phone: "090-7777-8888", message: "I want to place an order!")
        fake_request = Request.new(urgency: "1", 
        full_name: "Jane Doe", 
        email: "sample@gmail.com", 
        phone: "1234567890", 
        relationship: "0", 
        county: "0", 
        meet: "0", 
        address: "", 
        availability: "3 pm", 
        comments: "hi")
        UserMailer.with(request: fake_request).new_email
    end
end
