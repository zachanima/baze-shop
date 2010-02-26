class UsersController < ApplicationController
  before_filter :find_shop
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
    if @shop
      @user = @shop.users.build(params[:user])
    else
      @user = User.new(params[:user])
    end

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
    if @shop
      @users = @shop.users
    else
      @users = User.all
    end
  end

  def find_shop
    @shop = Shop.find(params[:shop_id]) unless params[:shop_id].nil?
  end
end
