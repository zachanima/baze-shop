class OrdersController < ApplicationController
  before_filter :find_shop, :only => [:index, :new]

  def index
    @orders = @shop ? @shop.orders : Order.all
  end

  def new
    @order = Order.new
    @shops = Shop.all
  end

  def edit
    @order = Order.find(params[:id])
  end
end
