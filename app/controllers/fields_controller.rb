class FieldsController < ApplicationController
  before_filter :authenticate
  before_filter :find_field, :only => [:edit, :update, :destroy]

  def new
    @field = Field.new
  end

  def create
    @field = @shop.fields.build(params[:field])
    if @field.save
      notice(edit_shop_path(@shop))
    else
      error(:new)
    end
  end

  # def edit

  def update
    if @field.update_attributes(params[:field])
      notice(edit_shop_path(@shop))
    else
      error(:edit)
    end
  end

  def destroy
    @field.destroy
    redirect_to(edit_shop_path(@shop))
  end

  def sort
    params[:fields].each_with_index do |id, index|
      Field.update_all(['position = ?', index + 1], ['id = ?', id])
    end
    render :nothing => true
  end

  private
  def find_field
    @field = Field.find(params[:id])
  end
end
