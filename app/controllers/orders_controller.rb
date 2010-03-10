class OrdersController < ApplicationController
  # Should authenticate on shopless orders and userless indices
  before_filter :authenticate, :except => [:index, :new, :review]
  before_filter :find_shop
  before_filter :find_order, :only => [:edit]

  def index
    @user = User.find(params[:user_id]) if params[:user_id]
    if @user
      @orders = @user.orders
      render_shop
    else
      authenticate
      @orders = @shop ? @shop.orders : Order.all
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
    redirect_to(review_shop_user_orders_path(@shop, @current_user))
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
end
