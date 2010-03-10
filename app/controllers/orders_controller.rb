class OrdersController < ApplicationController
  # Should authenticate on shopless orders and userless indices
  before_filter :authenticate, :except => [:index, :new]
  before_filter :find_shop

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

  def create
    @order = @current_user.orders.build(params[:order])
    @order.price *= @order.quantity unless @order.price.blank?
    @order.save
    redirect_to(shop_category_product_path(@shop, @order.product.category, @order.product))
  end

  def edit
    @order = Order.find(params[:id])
  end
end
