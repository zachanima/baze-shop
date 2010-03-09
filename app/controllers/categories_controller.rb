class CategoriesController < ApplicationController
  before_filter :authenticate, :except => [:index, :show]
  before_filter :find_shop
  before_filter :find_category, :only => [:edit, :show, :update]

  def index
    @categories = @shop.categories
    render_shop
  end

  def new
    @category = @shop.category.new
  end

  # def edit

  def show
    @products = @category.products
    render :layout => 'shop'
  end
  
  def create
    @category = @shop.categories.build(params[:category])
    if @category.save
      flash[:notice] = ['Created category', @category.name].join(' ')
      redirect_to(edit_shop_path(@shop))
    else
      flash[:error] = ['Could not create category', @category.name].join(' ')
      render :action => :new
    end
  end
  
  
  def update
    if @category.update_attributes(params[:category])
      flash[:notice] = 'Updated category'
      redirect_to(edit_shop_path(@shop))
    else
      flash[:error] = ['Could not update category', @category.name].join(' ')
      render :action => :edit
    end
  end
  
  # def destroy

  private
  def find_category
    @category = @shop.categories.find(params[:id])
  end
end
