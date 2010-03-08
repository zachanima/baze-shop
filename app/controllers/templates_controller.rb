class TemplatesController < ApplicationController
  before_filter :authenticate
  before_filter :find_product_template,  :only => [:edit, :show, :update]

  def index
    @shops = Shop.all
    @templates = Template.all
  end

  def new
    @product_template = Template.new
  end

  # def edit

  def create
    @product_template = Template.new(params[:template])
    if @product_template.save
      flash[:notice] = ['Created template', @product_template.name].join(' ')
      redirect_to(edit_template_path(@product_template))
    else
      flash[:error] = ['Could not create template', @product_template.name].join(' ')
      render :action => :new
    end
  end

  def update
    if @product_template.update_attributes(params[:template])
      flash[:notice] = ['Updated template', @product_template.name].join(' ')
      redirect_to(templates_path)
    else
      flash[:error] = ['Could not update template', @product_template.name].join(' ')
      render :action => :edit
    end
  end

  # def destroy

  def multiple
    if params[:template_ids].nil?
      flash[:error] = 'No templates selected'
    elsif params[:shop_id] != '0' # 'Add to shop...'
      @shop = Shop.find(params[:shop_id])
      if multiple_add_to_shop
        flash[:notice] = "Added #{params[:template_ids].count} products to shop #{@shop.name}"
      else
        flash[:notice] = "Could not add products to shop #{@shop.name} (Does the shop have any categories?)"
      end
    elsif params[:destroy]
      multiple_destroy
      flash[:notice] = "Deleted #{params[:template_ids].count} templates"
    else
      flash[:error] = "Unexpected error, params: #{params.inspect}"
    end
    redirect_to(templates_path)
  end

  private
  # Adds products to first category (or creates a 'root' category if necessary)
  def multiple_add_to_shop
    @shop.categories.build(:name => 'root').save if @shop.categories.empty?
    params[:template_ids].each do |template_id|
      unless @shop.categories.first.categorizations.build(:template_id => template_id).save
        return false
      end
    end
  end

  def multiple_destroy
    Template.destroy(params[:template_ids])
  end

  def find_product_template
    @product_template = Template.find(params[:id])
  end
end
