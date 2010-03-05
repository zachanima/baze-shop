require 'csv'

class ApplicationController < ActionController::Base
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

  private
  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.user
  end
end
