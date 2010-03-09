class UserSessionsController < ApplicationController
  before_filter :find_shop
    
  def new
    render :layout => 'shop'
  end

  def create
    @user = User.find(:all, :conditions => ['login = ? AND password = ? AND shop_id = ?', params[:login], params[:password], @shop.id]).first
    session[:user_id] = @user.id if @user
    if session[:user_id]
      redirect_to(shop_path(@shop))
    else
      render :action => :new, :layout => 'shop'
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to(shop_path(@shop))
  end
end
