class OptionsController < ApplicationController
  before_filter :authenticate, :except => [:show]
  before_filter :find_option_group
  before_filter :find_option,  :only => [:edit, :update]

  def new
    @option = Option.new
  end

  # def edit

  def create
    @option = @option_group.options.build(params[:option])
    if @option.save
      flash[:notice] = ['Created option', @option.text].join(' ')
      redirect_to(edit_option_group_path(@option_group))
    else
      flash[:error] = ['Could not create option', @option.text].join(' ')
      render :action => :new
    end
  end

  def update
    if @option.update_attributes(params[:option])
      flash[:notice] = ['Updated option', @option.text].join(' ')
      redirect_to(edit_option_group_path(@option_group))
    else
      flash[:error] = ['Could not update option', @option.text].join(' ')
      render :action => :edit
    end
  end


  def sort
    params[:options].each_with_index do |id, index|
      Option.update_all(['position = ?', index + 1], ['id = ?', id])
    end
    render :nothing => true
  end


  private
  def find_option
    @option = Option.find(params[:id])
  end
end
