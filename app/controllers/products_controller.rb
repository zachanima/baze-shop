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
      flash[:notice] = ['Created product', @product.name].join(' ')
      redirect_to(products_path)
    else
      flash[:error] = ['Could not create product', @product.name].join(' ')
      render :action => :new
    end
  end

  def update
    if @product.update_attributes(params[:product])
      flash[:notice] = ['Updated product', @product.name].join(' ')
      redirect_to(products_path)
    else
      flash[:error] = ['Could not update product', @product.name].join(' ')
      render :action => :edit
    end
  end

  # def destroy

  def multiple
    if @shop
      if multiple_add_to_shop
        flash[:notice] = "Added #{params[:product_ids].count} products to shop #{@shop.name}"
        redirect_to(products_path)
      else
        flash[:notice] = "Could not add products to shop #{@shop.name} (Does the shop have any categories?)"
      end
    end
  end

  private
  def multiple_add_to_shop
    if params[:product_ids]
      @shop.categories.build(:name => 'root').save if @shop.categories.empty?
      params[:product_ids].each do |product_id|
        unless @shop.categories.first.categorizations.build(:product_id => product_id).save
          return false
        end
      end
    end
  end

  def find_product
    @product = Product.find(params[:id])
  end
end
