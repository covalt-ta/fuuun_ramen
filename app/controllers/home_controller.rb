class HomeController < ApplicationController
  def index
    @products = Product.where(display: true).order(updated_at: :DESC).first(3)
    @informations = Information.order(updated_at: :DESC).first(6)
  end

  def test_sign_in
    @user = User.new
    @admin = Admin.new
  end
end
