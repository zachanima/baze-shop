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
    if @shop.closed
      render :layout => 'shop'
    else
      render_shop
    end
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

  def multiple
    if params[:shop_ids].nil?
      flash[:error] = 'No shops selected'
    elsif params[:destroy]
      multiple_destroy
      flash[:notice] = "Deleted #{params[:shop_ids].count} shops"
    else
      flash[:error] = "Unexpected error, params: #{params.inspect}"
    end
    redirect_to(shops_path)
  end


  private
  def find_shop
    @shop = Shop.find_by_link(params[:id])
  end

  def parameterize_link
    params[:shop][:link] = params[:shop][:link].parameterize if params[:shop] and params[:shop][:link]
  end

  def multiple_destroy
    Shop.destroy(params[:shop_ids])
  end
end
