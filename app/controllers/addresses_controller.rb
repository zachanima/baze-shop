class AddressesController < ApplicationController
  before_filter :find_shop
  before_filter :find_address, :only => [:edit, :update, :destroy]

  def new
    @address = Address.new
  end

  # def edit

  def create
    @address = @shop.addresses.build(params[:address])
    if @address.save
      flash[:notice] = ['Created address', @address.text].join(' ')
      redirect_to(edit_shop_path(@shop))
    else
      flash[:error] = ['Could not create address', @address.text].join(' ')
      render :action => :new
    end
  end

  def update
    if @address.update_attributes(params[:address])
      flash[:notice] = ['Updated address', @address.text].join(' ')
      redirect_to(edit_shop_path(@shop))
    else
      flash[:error] = ['Could not update address', @address.text].join(' ')
      render :action => :edit
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
