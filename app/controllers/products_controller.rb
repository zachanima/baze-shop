class ProductsController < ApplicationController
  before_filter :find_product,  :only => [:edit, :show, :update]
  before_filter :find_products, :only => [:index]
  before_filter :find_shops,    :only => [:index]

  def index
  end

  def new
    @product = Product.new
  end

  def edit
  end

  def create
    @product = Product.new(params[:product])
    if @product.save
      redirect_to(products_path)
    else
      render :action => :new
    end
  end

  def update
    if @product.update_attributes(params[:product])
      redirect_to(products_path)
    else
      render :action => :edit
    end
  end

  def multiple
    if params[:shop_id]
      multiple_add_to_shop
    else
      render :text => params.inspect
    end
  end

  private
  def multiple_add_to_shop
    if params[:product_ids].nil?
      redirect_to(products_path)
    else
      render :text => "Add products <em>#{params[:product_ids].collect{|id|Product.find(id).name}.join('</em>, <em>')}</em> to shop <em>#{Shop.find(params[:shop_id]).name}</em>"
    end
  end

  def find_product
    @product = Product.find(params[:id])
  end

  def find_products
    @products = Product.all
  end

  def find_shops
    @shops = Shop.all
  end
end
