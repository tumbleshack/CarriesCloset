# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
    def new_email
        # Set up a temporary order for the preview
        #order = Order.new(name: "Joe Smith", email: "joe@gmail.com", address: "1-2-3 Chuo, Tokyo, 333-0000", phone: "090-7777-8888", message: "I want to place an order!")
        fake_request = Request.new(urgency: "1", 
        full_name: "Jane Doe", 
        email: "sample@gmail.com", 
        phone: "1234567890", 
        relationship: 1, 
        county: "1", 
        meet: true, 
        address: "", 
        availability: "3 pm", 
        comments: "Hi, this is a note.")
        UserMailer.with(request: fake_request).new_email
    end

    def new_admin_urgent_email
        # Set up a temporary order for the preview
        #order = Order.new(name: "Joe Smith", email: "joe@gmail.com", address: "1-2-3 Chuo, Tokyo, 333-0000", phone: "090-7777-8888", message: "I want to place an order!")
        fake_request = Request.new(urgency: "1", 
        full_name: "Jane Doe", 
        email: "sample@gmail.com", 
        phone: "1234567890", 
        relationship: 1, 
        county: "1", 
        meet: true, 
        address: "", 
        availability: "3 pm", 
        comments: "Hi, this is a note.")
        UserMailer.with(request: fake_request).new_admin_urgent_email
    end
end
