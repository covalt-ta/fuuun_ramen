class HomeController < ApplicationController
  def index
    @ranking_products = Product.where(id: Product.set_ranking.first(3))
    @informations = Information.order(updated_at: :DESC).first(6)
    @contact = Contact.new
  end

  def test_sign_in
    @user = User.new
    @admin = Admin.new
  end
end
