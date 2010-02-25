class CategorizationsController < ApplicationController
  before_filter :find_categorization, :only => [:edit, :update]
  before_filter :find_shop

  def index
    @categorizations = @shop.categories.collect { |c| c.categorizations }.flatten
  end

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
    @shop = Shop.find(params[:shop_id])
  end
end
