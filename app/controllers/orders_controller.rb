class OrdersController < ApplicationController
  # Should authenticate on shopless orders and userless indices
  before_filter :authenticate, :except => [:index, :new, :create, :destroy, :review, :accept, :increment, :decrement]
  before_filter :find_shop
  before_filter :find_order, :only => [:edit, :destroy, :increment, :decrement]

  def index
    @user = User.find(params[:user_id]) if params[:user_id]
    if @user
      @orders = @user.accepted_orders
      render_shop
    else
      authenticate
      if @shop
        @orders = @shop.orders.reject { |o| o.order_group_id == nil }
      else
        @orders = OrderGroup.find(:all, :order => 'created_at DESC').collect { |order_group| order_group.orders }.flatten
      end
    end
  end

  def new
    @order = Order.new
    @shops = Shop.all
  end

  # def edit

  def create
    @order = @current_user.orders.build(params[:order])

    # validate
    @order.product.option_groups.each do |option_group|
      unless option_group.optional
        if @order.variations.select { |v| v.option.option_group === option_group }.compact.empty?
          if flash[:error]
            flash[:error] += ", #{option_group.text} ikke valgt"
          else
            flash[:error] = "#{option_group.text} ikke valgt"
          end
        end
      end
    end

    unless flash[:error]
      @order.update_price
      @order.save
    end

    redirect_to(shop_product_path(@shop, @order.product))
  end

  def destroy
    if @order.order_group_id == nil and @order.user === @current_user
      @order.destroy
    end

    if @current_user.waiting_orders.empty?
      render :update do |page|
        page.reload
      end
    else
      render :partial => 'cart'
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
    if @orders.empty?
      redirect_to(shop_path(@shop))
    else
      render_shop
    end
  end

  def accept
    @orders = @current_user.waiting_orders
    if @shop.addresses.empty? or not params[:order_group][:address_id].empty?
      if @orders.empty?
        @order_group = @current_user.order_groups.last
      else
        @order_group = @current_user.order_groups.build(params[:order_group])
        @order_group.address_id = nil if @order_group.address_id == 0
        @order_group.dummy = false
        @order_group.save
        @orders.each do |order|
          order.order_group_id = @order_group.id
          order.save
        end
        unless @current_user.dummy == true
          OrderGroupMailer.deliver_receipt(@order_group)
          OrderGroupMailer.deliver_user_receipt(@order_group) unless @current_user.email.blank? and @current_user.email_address.net
        end
        @order_group = @current_user.order_groups.last
      end
      render_shop
    else 
      flash[:error] = 'Leveringsadresse ikke valgt'
      redirect_to(review_shop_user_orders_path(@shop, @current_user))
    end
  end

  def increment
    @order.quantity += 1
    @order.update_price
    @order.save
    render :partial => 'cart'
  end

  def decrement
    @order.quantity -= 1
    if @order.quantity == 0
      @order.destroy
    else
      @order.update_price
      @order.save
    end

    if @current_user.waiting_orders.empty?
      render :update do |page|
        page.reload
      end
    else
      render :partial => 'cart'
    end
  end

  private
  def find_order
    @order = Order.find(params[:id])
  end

  def multiple_destroy
    Order.destroy(params[:order_ids])
  end
end
