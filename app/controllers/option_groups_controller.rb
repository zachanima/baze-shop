class OptionGroupsController < ApplicationController
  before_filter :authenticate
  before_filter :find_option_group, :only => [:edit, :update]

  def index
    @option_groups = OptionGroup.all(:order => 'position')
  end

  def new
    @option_group = OptionGroup.new
  end

  # def edit

  def create
    @option_group = OptionGroup.new(params[:option_group])
    if @option_group.save
      flash[:notice] = ['Created option group', @option_group.name].join(' ')
      redirect_to(edit_option_group_path(@option_group))
    else
      flash[:error] = ['Could not create option group', @option_group.name].join(' ')
      render :action => :new
    end
  end

  def update
    if @option_group.update_attributes(params[:option_group])
      flash[:notice] = ['Updated option group', @option_group.name].join(' ')
      redirect_to(option_groups_path)
    else
      flash[:error] = ['Could not update option group', @option_group.name].join(' ')
      render :action => :edit
    end
  end

  def multiple
    if params[:option_group_ids].nil?
      flash[:error] = 'No option groups selected'
    elsif params[:destroy]
      multiple_destroy
      flash[:notice] = "Deleted #{params[:option_group_ids].count} option groups"
    else
      flash[:error] = "Unexpected error, params: #{params.inspect}"
    end
    redirect_to(option_groups_path)
  end

  def sort
    params[:option_groups_list].each_with_index do |id, index|
      OptionGroup.update_all(['position = ?', index + 1], ['id = ?', id])
    end
    render :update do |page|
      page.reload
    end
  end

  private
  def find_option_group
    @option_group = OptionGroup.find(params[:id])
  end

  def multiple_destroy
    OptionGroup.destroy(params[:option_group_ids])
  end
end
