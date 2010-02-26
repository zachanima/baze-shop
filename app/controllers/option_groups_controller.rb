class OptionGroupsController < ApplicationController
  before_filter :find_option_group, :only => [:edit, :update]

  def index
    @option_groups = OptionGroup.all
  end

  def new
    @option_group = OptionGroup.new
  end

  # def edit

  def create
    if OptionGroup.new(params[:option_group]).save
      flash[:notice] = 'Created option group.'
      redirect_to(option_groups_path)
    else
      render :action => :new
    end
  end

  def update
    if @option_group.update_attributes(params[:option_group])
      flash[:notice] = 'Updated option group.'
      redirect_to(option_groups_path)
    else
      render :action => :edit
    end
  end

  # def destroy

  private
  def find_option_group
    @option_group = OptionGroup.find(params[:id])
  end
end
