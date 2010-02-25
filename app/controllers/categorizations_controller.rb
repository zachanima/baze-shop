class CategorizationsController < ApplicationController
  before_filter :find_categorization, :only => [:edit, :update]
  before_filter :find_shop, :only => [:edit, :update]

  def edit
    @category = @categorization.category
  end

  def update
    if @categorization.update_attributes(params[:categorization])
      redirect_to(shop_categories_path(@shop))
    else
      render :action => :edit
    end
  end

  private
  def find_categorization
    @categorization = Categorization.find(params[:id])
  end

  def find_shop
    @shop = @categorization.category.shop
  end
end
