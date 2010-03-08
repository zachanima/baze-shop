class ImagesController < ApplicationController
  before_filter :authenticate
  before_filter :find_product_template

  def new
    @image = Image.new
  end

  def edit
  end

  def create
    @image = @product_template.images.build(params[:image])
    if @image.save
      flash[:notice] = ['Created image', @image.name].join(' ')
      redirect_to(edit_template_path(@product_template))
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
  def find_product_template
    @product_template = Template.find(params[:template_id])
  end
end
