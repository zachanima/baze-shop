class UserGroupsController < ApplicationController
  before_filter :authenticate
  before_filter :find_shop
  before_filter :find_user_group, :only => [:edit, :update, :destroy]

  def new
    @user_group = UserGroup.new
  end

  # def edit

  def create
    @user_group = @shop.user_groups.build(params[:user_group])
    if @user_group.save
      flash[:notice] = ['Created user group', @user_group.name].join(' ')
      redirect_to(edit_shop_path(@shop))
    else
      flash[:error] = ['Could not create user group', @user_group.name].join(' ')
      render :action => :new
    end
  end

  def update
    if @user_group.update_attributes(params[:user_group])
      flash[:notice] = ['Updated user group', @user_group.name].join(' ')
      redirect_to(edit_shop_path(@shop))
    else
      flash[:error] = ['Could not update user', @user_group.name].join(' ')
      render :action => :edit
    end
  end

  def destroy
    @user_group.destroy
    redirect_to(edit_shop_path(@shop))
  end

  private
  def find_user_group
    @user_group = UserGroup.find(params[:id])
  end
end
