class CategoriesController < ApplicationController
  before_filter :find_category, :only => [:edit, :update]
  before_filter :find_shop

  def new
    @category = Category.new
  end

  def edit
  end
  
  def create
    if @shop.categories.build(params[:category]).save
      flash[:notice] = 'Successfully created category.'
      redirect_to(edit_shop_path(@shop))
    else
      render :action => :new
    end
  end
  
  
  def update
    if @category.update_attributes(params[:category])
      flash[:notice] = 'Successfully updated category.'
      redirect_to(edit_shop_path(@shop))
    else
      render :action => :edit
    end
  end
  
  def destroy
  end

  private
  def find_category
    @category = Category.find(params[:id])
  end

  def find_shop
    @shop = Shop.find(params[:shop_id])
  end
end
