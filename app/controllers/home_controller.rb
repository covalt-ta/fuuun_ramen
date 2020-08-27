class HomeController < ApplicationController
  def index
    @products = Product.order(created_at: :DESC).first(3)
    @informations = Information.order(created_at: :DESC).first(6)
  end
end
