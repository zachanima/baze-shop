class OptionsController < ApplicationController
  before_filter :authenticate, :except => [:show]
  before_filter :find_option_group

  def new
    @option = Option.new
  end

  def create
    @option = @option_group.options.build(params[:option])
    if @option.save
      flash[:notice] = ['Created option', @option.text].join(' ')
      redirect_to(edit_option_group_path(@option_group))
    else
      flash[:notice] = ['Could not create option', @option.text].join(' ')
      render :action => :new
    end
  end


  def sort
    params[:options].each_with_index do |id, index|
      Option.update_all(['position = ?', index + 1], ['id = ?', id])
    end
    render :nothing => true
  end
end
