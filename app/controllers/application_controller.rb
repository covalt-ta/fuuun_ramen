class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :basic_auth
  before_action :set_shop

  def after_sign_in_path_for(resource)
    if resource.is_a?(User)
      products_path
    elsif resource.is_a?(Admin)
      admins_root_path
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :last_name, :first_name, :last_name_kana, :first_name_kana, :birthday])
  end

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV['BASIC_AUTH_USER'] && password == ENV['BASIC_AUTH_PASSWORD']
    end
  end

  def set_shop
    if Shop.exists?
      admin_user = Admin.first
      @shop = Shop.find(admin_user.shop.id)
    end
  end
end
