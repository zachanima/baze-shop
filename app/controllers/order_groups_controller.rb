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

  def multiple
    if params[:order_group_ids].nil?
      flash[:error] = 'No orders selected'
    elsif params[:destroy]
      multiple_destroy
      flash[:notice] = "Deleted #{params[:order_group_ids].count} orders"
    else
      flash[:error] = "Unexpected error, params: #{params.inspect}"
    end
    redirect_to(@shop ? shop_order_groups_path(@shop) : order_groups_path)
  end

  private
  def multiple_destroy
    OrderGroup.destroy(params[:order_group_ids])
  end
end
