class OptionGroupsController < ApplicationController
  before_filter :authenticate
  before_filter :find_option_group, :only => [:edit, :update]

  def index
    @option_groups = OptionGroup.all
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

  # def destroy

  private
  def find_option_group
    @option_group = OptionGroup.find(params[:id])
  end
end
