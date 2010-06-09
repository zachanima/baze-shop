class OrderGroupsController < ApplicationController
  before_filter :authenticate
  before_filter :find_shop

  def index
    if @shop
      @order_groups = OrderGroup.find(:all, :conditions => { :dummy => false, :user_id => @shop.users.map(&:id) }, :order => 'id DESC')
    else
      @order_groups = OrderGroup.find(:all, :conditions => { :dummy => false }, :order => 'id DESC')
    end
  end

  def destroy
    OrderGroup.find(params[:id]).destroy
    redirect_to(@shop ? shop_order_groups_path(@shop) : order_groups_path)
  end
end
