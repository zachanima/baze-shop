require 'csv'

class UsersController < ApplicationController
  before_filter :authenticate, :except => [:show]
  before_filter :find_shop
  before_filter :find_user, :only => [:show, :edit, :update, :destroy]

  def index
    @users = @shop ? @shop.users.all(:order => 'first_name, last_name') : User.all(:order => 'first_name, last_name')

    respond_to do |format|
      format.html
      format.csv do
        CSV.open('public/all_users.csv', 'w') do |csv|
          header = Array.new
          header << 'Name'
          header << 'Department'
          header << 'Login'
          header << 'Password'
          header << 'Email'
          header << 'Telephone'
          header << 'Address'
          header << 'Text'
          header << 'Budget'
          header << 'Balance'
          csv << header.flatten
          @users.each do |user|
            row = Array.new
            row << user.name
            row << user.department
            row << user.login
            row << user.password
            row << user.email
            row << user.telephone
            row << user.address.gsub("\r\n", ',')
            row << user.text.gsub("\r\n", ',')
            row << user.budget
            row << user.balance
            csv << row.flatten
          end
        end
        render :file => 'public/all_users.csv', :layout => false
      end
    end
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

  def destroy
    shop = @user.shop
    @user.destroy
    notice(shop_users_path(shop))
  end

  def multiple
    if params[:user_ids].nil?
      flash[:error] = 'No users selected'
    elsif params[:destroy]
      multiple_destroy
      flash[:notice] = "Deleted #{params[:user_ids].count} users"
    else
      flash[:error] = "Unexpected error, params: #{params.inspect}"
    end
    if @shop
      redirect_to(shop_users_path(@shop))
    else
      redirect_to(users_path)
    end
  end

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
        unless fields[key].empty?
          if user[fields[key].to_sym].nil?
            user[fields[key].to_sym] = params[:attributes][row][key]
          else
            user[fields[key].to_sym] += "\r\n" + params[:attributes][row][key]
          end
        end
      end
      user[:password] = params[:password] unless user[:password]
      user[:department] = params[:department] unless user[:department]
      if user[:text]
        user[:text] = params[:text] + ' ' + user[:text] unless params[:text].nil?
      else
        user[:text] = params[:text] unless params[:text].nil?
      end
      @shop.users.create(user)
    end
    flash[:notice] = "Imported #{params[:rows].count} users"
    redirect_to shop_users_path(@shop)
  end

  private
  def find_user
    @user = User.find(params[:id])
  end

  def multiple_destroy
    User.destroy(params[:user_ids])
  end
end
