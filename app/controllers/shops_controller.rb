class ShopsController < ApplicationController
  before_filter :authenticate, :except => [:show]
  before_filter :find_shop, :only => [:edit, :show, :update]
  before_filter :parameterize_link, :only => [:create, :update]

  def index
    @shops = Shop.all
  end

  def new
    @shop = Shop.new
  end

  # def edit

  def show
    render :layout => 'shop'
  end

  def create
    @shop = Shop.new(params[:shop])
    if @shop.save
      flash[:notice] = ['Created shop', @shop.name].join(' ')
      redirect_to(edit_shop_path(@shop))
    else
      flash[:error] = ['Could not create shop', @shop.name].join(' ')
      render :action => :new
    end
  end

  def update
    if @shop.update_attributes(params[:shop])
      flash[:notice] = ['Updated shop', @shop.name].join(' ')
      redirect_to(shops_path)
    else
      flash[:error] = ['Could not update shop', @shop.name].join(' ')
      render :action => :edit
    end
  end

  # def destroy

  private
  def find_shop
    @shop = Shop.find_by_link(params[:id])
  end

  def parameterize_link
    params[:shop][:link] = params[:shop][:link].parameterize if params[:shop] and params[:shop][:link]
  end
end
