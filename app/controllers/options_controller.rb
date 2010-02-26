class OptionsController < ApplicationController
  before_filter :find_option_group

  def new
    @option = Option.new
  end

  def create
    option = @option_group.options.build(params[:option])
    if option.save
      flash[:notice] = 'Created option.'
      redirect_to(edit_option_group_path(@option_group))
    else
      render :action => :new
    end
  end
end
