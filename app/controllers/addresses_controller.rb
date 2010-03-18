class AddressesController < ApplicationController
  before_filter :authenticate
  before_filter :find_address, :only => [:edit, :update, :destroy]

  def new
    @address = Address.new
  end

  def create
    @address = @shop.addresses.build(params[:address])
    if @address.save
      notice(@address, edit_shop_path(@shop))
    else
      error(@address, :new)
    end
  end

  # def edit

  def update
    if @address.update_attributes(params[:address])
      notice(@address, edit_shop_path(@shop))
    else
      error(@address, :edit)
    end
  end

  def destroy
    @address.destroy
  end

  def sort
    params[:addresses].each_with_index do |id, index|
      Address.update_all(['position = ?', index + 1], ['id = ?', id])
    end
    render :nothing => true
  end

  private
  def find_address
    @address = Address.find(params[:id])
  end
end
