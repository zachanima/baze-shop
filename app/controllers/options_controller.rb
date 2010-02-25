class OptionsController < ApplicationController
  before_filter :find_option_group

  def new
    @option = Option.new
  end

  def create
    if @option_group.options.build(params[:option]).save
      redirect_to(edit_option_group_path(@option_group))
    else
      render :action => :new
    end
  end

  private
  def find_option_group
    @option_group = OptionGroup.find(params[:option_group_id])
  end
end
