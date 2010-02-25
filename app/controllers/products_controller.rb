class ProductsController < ApplicationController
  before_filter :find_product,  :only => [:edit, :show, :update]
  before_filter :find_products, :only => [:index]

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

  private
  def find_product
    @product = Product.find(params[:id])
  end

  def find_products
    @products = Product.all
  end
end
