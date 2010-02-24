class ShopsController < ApplicationController
  before_filter :find_shop, :only => [:edit, :show, :update]
  before_filter :find_shops, :only => [:index]

  def index
  end

  def new
    @shop = Shop.new
  end

  def edit
  end

  def show
  end

  def create
    @shop = Shop.new(params[:shop])
    if @shop.save
      redirect_to(shops_path)
    else
      render :action => :new
    end
  end

  def update
    if @shop.update_attributes(params[:shop])
      redirect_to(shops_path)
    else
      render :action => :edit
    end
  end

  def destroy
  end

  private
  def find_shop
    @shop = Shop.find(params[:id])
  end

  def find_shops
    @shops = Shop.all
  end
end
