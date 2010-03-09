require 'csv'

class ApplicationController < ActionController::Base
  before_filter :find_current_user

  helper :all
  protect_from_forgery

  def find_option_group
    @option_group = OptionGroup.find(params[:option_group_id]) if params[:option_group_id]
  end

  def find_shop
    @shop = Shop.find_by_link(params[:shop_id]) if params[:shop_id]
  end

  protected
  def authenticate
    authenticate_or_request_with_http_basic do |login, password|
      login == 'os' && password == 'secret'
    end
  end

  def find_current_user
    @current_user = User.find(session[:user_id]) if session[:user_id]
  end
end
