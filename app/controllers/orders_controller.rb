class OrdersController < ApplicationController
  def index
    @orders = Order.all
  end

  def new
    @order = Order.new
  end

  def edit
    @order = Order.find(params[:id])
  end
end
