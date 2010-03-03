class ProductsController < ApplicationController
  before_filter :find_product,  :only => [:edit, :show, :update]

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
    if params[:product_ids].nil?
      flash[:error] = 'No products selected'
    elsif params[:shop_id] != '0' # 'Add to shop...'
      @shop = Shop.find(params[:shop_id])
      if multiple_add_to_shop
        flash[:notice] = "Added #{params[:product_ids].count} products to shop #{@shop.name}"
      else
        flash[:notice] = "Could not add products to shop #{@shop.name} (Does the shop have any categories?)"
      end
    elsif params[:destroy]
      multiple_destroy
      flash[:notice] = "Deleted #{params[:product_ids].count} products"
    else
      flash[:error] = "Unexpected error, params: #{params.inspect}"
    end
    redirect_to(products_path)
  end

  private
  # Adds products to first category (or creates a 'root' category if necessary)
  def multiple_add_to_shop
    @shop.categories.build(:name => 'root').save if @shop.categories.empty?
    params[:product_ids].each do |product_id|
      unless @shop.categories.first.categorizations.build(:product_id => product_id).save
        return false
      end
    end
  end

  def multiple_destroy
    Product.destroy(params[:product_ids])
  end

  def find_product
    @product = Product.find(params[:id])
  end
end
