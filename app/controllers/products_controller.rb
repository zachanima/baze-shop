class ProductsController < ApplicationController
  before_filter :find_product,  :only => [:edit, :show, :update]
  before_filter :find_shop, :only => [:multiple]

  def index
    @shops = Shop.all
    @products = Product.all
  end

  def new
    @product = Product.new
  end

  # def edit

  def create
    @product = Product.new(params[:product])
    if @product.save
      flash[:notice] = 'Created product.'
      redirect_to(products_path)
    else
      render :action => :new
    end
  end

  def update
    if @product.update_attributes(params[:product])
      flash[:notice] = 'Updated product.'
      redirect_to(products_path)
    else
      render :action => :edit
    end
  end

  # def destroy

  def multiple
    if @shop
      multiple_add_to_shop
      flash[:notice] = 'Added products to shop.'
    end
    redirect_to(products_path)
  end

  private
  def multiple_add_to_shop
    if params[:product_ids]
      params[:product_ids].each do |product_id|
        @shop.categories.first.categorizations.build(:product_id => product_id).save
      end
    end
  end

  def find_product
    @product = Product.find(params[:id])
  end
end
