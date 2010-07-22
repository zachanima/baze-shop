class CategoriesController < ApplicationController
  handles_sorting_of_nested_set
  before_filter :authenticate, :except => [:index, :show]
  before_filter :find_shop
  before_filter :find_category, :only => [:edit, :show, :update, :destroy]

  def index
    @categories = @shop.categories(:order => 'position')
    render_shop
  end

  def new
    @category = Category.new
  end

  # def edit

  def show
    @products = @category.products.all(:order => 'position')
    filter_user_groups!(@products)
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
      flash[:notice] = ['Updated category', @category.name].join(' ')
      redirect_to(edit_shop_path(@shop))
    else
      flash[:error] = ['Could not update category', @category.name].join(' ')
      render :action => :edit
    end
  end
  
  def destroy
    @category.products.each do |p|
      p.category = nil
      p.save
    end
    @category.destroy
    redirect_to(edit_shop_path(@shop))
  end


  def sort
    @category = Category.find(params[:moved_category_id])
    new_position = position_of(:moved_category_id).in_tree(:categories_tree)

    if new_position[:parent]
      @category.move_to_child_of(new_position[:parent])
    else
      @category.move_to_root
    end unless @category.parent_id === new_position[:parent]

    if new_position[:move_to_right_of]
      @category.move_to_right_of(new_position[:move_to_right_of])
    else
      @category.move_to_left_of(new_position[:move_to_left_of])
    end

    params[:categories_tree].each do |category_params|
      index = category_params.first.to_i
      id = category_params.last[:id]
      Category.update_all(['position = ?', index + 1], ['id = ?', id])
    end
    
    render :nothing => true
  end

  private
  def find_category
    @category = @shop.categories.find(params[:id])
  end
end
