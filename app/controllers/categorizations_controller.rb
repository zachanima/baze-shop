class CategorizationsController < ApplicationController
  before_filter :authenticate, :except => [:show]
  before_filter :find_categorization, :only => [:edit, :show, :update]
  before_filter :find_shop

  def index
    @categorizations = @shop.categories.collect { |c| c.categorizations }.flatten
  end

  def edit
    @categories = @categorization.category.shop.categories
  end

  def show
    render :layout => 'shop'
  end

  def update
    if @categorization.update_attributes(params[:categorization])
      flash[:notice] = ['Updated categorization', @categorization.template.name].join(' ')
      redirect_to(shop_categorizations_path(@shop))
    else
      flash[:error] = ['Could not update categorization', @categorization.template.name].join(' ')
      render :action => :edit
    end
  end

  def multiple
    if params[:categorization_ids].nil?
      flash[:error] = 'No products selected'
    elsif params[:destroy]
      multiple_destroy
      flash[:notice] = "Deleted #{params[:categorization_ids].count} products from #{@shop.name}"
    else
      flash[:error] = "Unexpected error, params: #{params.inspect}"
    end
    redirect_to(shop_categorizations_path)
  end

  private
  def find_categorization
    @categorization = Categorization.find(params[:id])
  end

  def multiple_destroy
    Categorization.destroy(params[:categorization_ids])
  end
end
