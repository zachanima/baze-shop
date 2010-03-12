class EmailAddressesController < ApplicationController
  before_filter :authenticate
  before_filter :find_shop
  before_filter :find_email_address, :only => [:edit, :update, :destroy]

  def new
    @email_address = EmailAddress.new
  end

  # def edit

  def create
    @email_address = @shop.email_addresses.build(params[:email_address])
    if @email_address.save
      flash[:notice] = ['Created email address', @email_address.text].join(' ')
      redirect_to(edit_shop_path(@shop))
    else
      flash[:error] = ['Could not create email address', @email_address.text].join(' ')
      render :action => :new
    end
  end

  def update
    if @email_address.update_attributes(params[:email_address])
      flash[:notice] = ['Updated email address', @email_address.text].join(' ')
      redirect_to(edit_shop_path(@shop))
    else
      flash[:error] = ['Could not update email address', @email_address.text].join(' ')
      render :action => :edit
    end
  end

  def destroy
    @email_address.destroy
  end

  def sort
    params[:email_addresses].each_with_index do |id, index|
      Address.update_all(['position = ?', index + 1], ['id = ?', id])
    end
    render :nothing => true
  end

  private
  def find_email_address
    @email_address = EmailAddress.find(params[:id])
  end
end
