class CategoriesController < ApplicationController
  before_filter :find_category, :only => [:edit, :update]
  before_filter :find_shop

  def new
    @category = Category.new
  end

  # def edit
  
  def create
    category = @shop.categories.build(params[:category])
    if category.save
      flash[:notice] = 'Created category.'
      redirect_to(edit_shop_path(@shop))
    else
      render :action => :new
    end
  end
  
  
  def update
    if @category.update_attributes(params[:category])
      flash[:notice] = 'Updated category.'
      redirect_to(edit_shop_path(@shop))
    else
      render :action => :edit
    end
  end
  
  # def destroy

  private
  def find_category
    @category = Category.find(params[:id])
  end
end
