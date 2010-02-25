class ProductsController < ApplicationController
  before_filter :find_product,  :only => [:edit, :show, :update]

  def index
    @shops = Shop.all
    @products = Product.all
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
      multiple_add_to_shop(params[:shop_id])
    else
      render :text => params.inspect
    end
    redirect_to(products_path)
  end

  private
  def multiple_add_to_shop(shop_id)
    unless params[:product_ids].nil?
      shop = Shop.find(shop_id)
      params[:product_ids].each do |product_id|
        shop.categories.first.categorizations.build(:product_id => product_id).save
      end
      flash[:notice] = "Added products <em>#{params[:product_ids].collect{|id|Product.find(id).name}.join('</em>, <em>')}</em> to shop <em>#{Shop.find(params[:shop_id]).name}</em>"
    end
  end

  def find_product
    @product = Product.find(params[:id])
  end
end
