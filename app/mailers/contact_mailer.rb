class ContactMailer < ApplicationMailer
  # default from: "no-replay@gmail.com"

  def send_mail(contact)
    @contact = contact
    mail(
      from: ENV['GMAIL_USER_NAME'],
      to:   "taku.covayashi@gmail.com",
      subject: 'お問い合わせ',
    )
  end
end
