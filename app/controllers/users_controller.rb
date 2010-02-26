class UsersController < ApplicationController
  before_filter :find_shop
  before_filter :find_user, :only => [:edit, :update]

  def index
    @users = @shop ? @shop.users : User.all
  end

  def new
    @user = User.new
  end

  # def edit

  def create
    @user = @shop ? @shop.users.build(params[:user]) : User.new(params[:user])
    if @user.save
      flash[:notice] = ['Created user', @user.name].join(' ')
      redirect_to(users_path)
    else
      flash[:error] = ['Could not create user', @user.name].join(' ')
      render :action => :new
    end
  end

  def update
    if @user.update_attributes(params[:user])
      flash[:notice] = ['Updated user', @user.name].join(' ')
      redirect_to(users_path)
    else
      flash[:error] = ['Could not update user', @user.name].join(' ')
      render :action => :edit
    end
  end

  # def destroy

  private
  def find_user
    @user = User.find(params[:id])
  end
end
