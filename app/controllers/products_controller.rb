class ProductsController < ApplicationController
  before_filter :authenticate, :except => [:show]
  before_filter :find_product, :only => [:edit, :show, :update]
  before_filter :find_shop

  def index
    @products = @shop.categories.collect { |c| c.products }.flatten
  end

  def edit
    @categories = @product.category.shop.categories
  end

  def show
    render :layout => 'shop'
  end

  def update
    if @product.update_attributes(params[:product])
      flash[:notice] = ['Updated product', @product.template.name].join(' ')
      redirect_to(shop_products_path(@shop))
    else
      flash[:error] = ['Could not update product', @product.template.name].join(' ')
      render :action => :edit
    end
  end

  def multiple
    if params[:product_ids].nil?
      flash[:error] = 'No products selected'
    elsif params[:destroy]
      multiple_destroy
      flash[:notice] = "Deleted #{params[:product_ids].count} products from #{@shop.name}"
    else
      flash[:error] = "Unexpected error, params: #{params.inspect}"
    end
    redirect_to(shop_products_path)
  end

  private
  def find_product
    @product = Product.find(params[:id])
  end

  def multiple_destroy
    Product.destroy(params[:product_ids])
  end
end
