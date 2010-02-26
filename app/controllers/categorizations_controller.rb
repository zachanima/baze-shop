class CategorizationsController < ApplicationController
  before_filter :find_categorization, :only => [:edit, :update]
  before_filter :find_shop

  def index
    @categorizations = @shop.categories.collect { |c| c.categorizations }.flatten
  end

  def edit
    @categories = @categorization.category.shop.categories
  end

  def update
    if @categorization.update_attributes(params[:categorization])
      flash[:notice] = ['Updated categorization', @categorization.product.name].join(' ')
      redirect_to(shop_categorizations_path(@shop))
    else
      flash[:error] = ['Could not update categorization', @categorization.product.name].join(' ')
      render :action => :edit
    end
  end

  private
  def find_categorization
    @categorization = Categorization.find(params[:id])
  end
end
