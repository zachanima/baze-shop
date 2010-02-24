class UsersController < ApplicationController
  before_filter :find_user,  :only => [:edit, :show, :update]
  before_filter :find_users, :only => [:index]

  def index
  end

  def new
    @user = User.new
  end

  def edit
  end

  def show
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to(users_path)
    else
      render :action => :new
    end
  end

  def update
    if @user.update_attributes(params[:user])
      redirect_to(users_path)
    else
      render :action => :new
    end
  end

  def destroy
  end

  private
  def find_user
    @user = User.find(params[:id])
  end

  def find_users
    @users = User.all
  end
end
