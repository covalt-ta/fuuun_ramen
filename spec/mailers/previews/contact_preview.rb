# Preview all emails at http://localhost:3000/rails/mailers/contact
class ContactPreview < ActionMailer::Preview
  def contact
    contact = Contact.new(name: "test", email: "test@gmail.com", text: "こんにちは、よろしくお願いします。")
    ContactMailer.send_mail(contact)
  end
end
