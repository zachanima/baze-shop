class ImagesController < ApplicationController
  before_filter :find_product

  def new
    @image = Image.new
  end

  def edit
  end

  def create
    @image = @product.images.build(params[:image])
    if @image.save
      flash[:notice] = ['Created image', @image.name].join(' ')
      redirect_to(edit_product_path(@product))
    else
      flash[:error] = ['Could not create image', @image.name].join(' ')
      render :action => :new
    end
  end

  def update
  end

  def destroy
  end

  private
  def find_product
    @product = Product.find(params[:product_id])
  end
end
