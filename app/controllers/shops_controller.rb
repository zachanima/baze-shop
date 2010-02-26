class ShopsController < ApplicationController
  before_filter :find_shop, :only => [:edit, :show, :update]
  before_filter :parameterize_link, :only => [:create, :update]

  def index
    @shops = Shop.all
  end

  def new
    @shop = Shop.new
  end

  # def edit

  # def show

  def create
    @shop = Shop.new(params[:shop])
    if @shop.save
      flash[:notice] = 'Created shop.'
      redirect_to(edit_shop_path(@shop))
    else
      render :action => :new
    end
  end

  def update
    if @shop.update_attributes(params[:shop])
      flash[:notice] = 'Updated shop.'
      redirect_to(shops_path)
    else
      render :action => :edit
    end
  end

  # def destroy

  private
  def find_shop
    @shop = Shop.find(params[:id])
  end

  def parameterize_link
    params[:shop][:link] = params[:shop][:link].parameterize if params[:shop] and params[:shop][:link]
  end
end
