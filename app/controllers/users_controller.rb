class UsersController < ApplicationController
  before_filter :authenticate, :except => [:show]
  before_filter :find_shop
  before_filter :find_user, :only => [:show, :edit, :update]

  def index
    @users = @shop ? @shop.users.all(:order => 'first_name, last_name') : User.all(:order => 'first_name, last_name')
  end

  def new
    @user = User.new
    @shops = Shop.all
  end

  # def edit

  def show
    render_shop
  end

  def create
    @user = @shop.users.build(params[:user])
    if @user.save
      flash[:notice] = ['Created user', @user.name].join(' ')
      redirect_to(shop_users_path(@shop))
    else
      flash[:error] = ['Could not create user', @user.name].join(' ')
      render :action => :new
    end
  end

  def update
    if @user.update_attributes(params[:user])
      flash[:notice] = ['Updated user', @user.name].join(' ')
      redirect_to(shop_users_path(@shop))
    else
      flash[:error] = ['Could not update user', @user.name].join(' ')
      render :action => :edit
    end
  end

  # def destroy

  def import
    @shops = Shop.all
  end

  def upload
    @users = CSV.parse(params[:file].read)
    @columns = 0
    @users.each do |user|
      @columns = user.count if user.count > @columns
    end
  end

  def import_create
    fields = params[:fields]
    params[:rows].each do |row|
      user = Hash.new
      params[:attributes][row].each_key do |key|
        user[fields[key].to_sym] = params[:attributes][row][key] unless fields[key].empty?
      end
      user[:password] = params[:password] unless user[:password]
      user[:department] = params[:department] unless user[:department]
      @shop.users.create(user)
    end
    flash[:notice] = "Imported #{params[:rows].count} users"
    redirect_to shop_users_path(@shop)
  end

  private
  def find_user
    @user = User.find(params[:id])
  end
end
