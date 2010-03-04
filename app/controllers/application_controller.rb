require 'csv'

class ApplicationController < ActionController::Base
  helper :all
  protect_from_forgery

  def find_option_group
    @option_group = OptionGroup.find(params[:option_group_id]) if params[:option_group_id]
  end

  def find_shop
    @shop = Shop.find(params[:shop_id]) if params[:shop_id]
  end

  protected
  def authenticate
    authenticate_or_request_with_http_basic do |login, password|
      login == 'os' && password == 'secret'
    end
  end
end
