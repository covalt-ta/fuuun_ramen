class ContactsController < ApplicationController
  def create
    contact = Contact.new(contact_params)
    if contact.save
      ContactMailer.send_mail(contact).deliver_now
      redirect_to root_path, notice: "お問い合わせを送信しました"
    else
      redirect_to root_path, alert: "お問い合わせを送信できませんでした"
    end
  end

  private
  def contact_params
    params.require(:contact).permit(:name, :email, :text, :phone_number)
  end
end
