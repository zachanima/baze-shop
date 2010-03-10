class OrdersController < ApplicationController
  # Should authenticate on shopless orders and userless indices
  before_filter :authenticate, :except => [:index, :new, :review]
  before_filter :find_shop
  before_filter :find_order, :only => [:edit, :destroy]

  def index
    @user = User.find(params[:user_id]) if params[:user_id]
    if @user
      @orders = @user.accepted_orders
      render_shop
    else
      authenticate
      @orders = @shop ? @shop.orders.select { |o| o.accepted = true } : Order.all(:conditions => { :accepted => true })
    end
  end

  def new
    @order = Order.new
    @shops = Shop.all
  end

  # def edit

  def create
    @order = @current_user.orders.build(params[:order])
    @order.price *= @order.quantity unless @order.price.blank?
    @order.accepted = false
    @order.save
    redirect_to(shop_product_path(@shop, @order.product))
  end

  def destroy
    if @order.user === @current_user
      @order.destroy
    end

    if @current_user.waiting_orders.empty?
      redirect_to(shop_path(@shop))
    else
      redirect_to(review_shop_user_orders_path(@shop, @current_user))
    end
  end


  def multiple
    if params[:order_ids].nil?
      flash[:error] = 'No orders selected'
    elsif params[:destroy]
      multiple_destroy
      flash[:notice] = "Deleted #{params[:order_ids].count} orders"
    else
      flash[:error] = "Unexpected error, params: #{params.inspect}"
    end
    redirect_to(@shop ? shop_orders_path(@shop) : orders_path)
  end


  # Cart
  def review
    @orders = @current_user.waiting_orders
    render_shop
  end

  def accept
    @orders = @current_user.waiting_orders
    @orders.each do |order|
      order.accepted = true
      order.save
    end
    render_shop
  end

  private
  def find_order
    @order = Order.find(params[:id])
  end

  def multiple_destroy
    Order.destroy(params[:order_ids])
  end
end
