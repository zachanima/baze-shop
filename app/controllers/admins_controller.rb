class AdminsController < ApplicationController
  before_filter :authenticate, :except => [:show]

  def index
    @admin = Admin.find(:first)
    @changes = Change.find(:all, :order => 'id DESC')
  end

  def edit
    @admin = Admin.find(params[:id])
  end

  def update
    @admin = Admin.find(params[:id])
    if @admin.update_attributes(params[:admin])
      flash[:notice] = ['Updated admin', @admin.login].join(' ')
      redirect_to(admins_path)
    else
      flash[:error] = ['Could not update admin', @admin.login].join(' ')
      render :action => :edit
    end
  end
end
