class ChangesController < ApplicationController
  before_filter :authenticate
  before_filter :find_change, :only => [:edit, :update]

  def new
    @change = Change.new
  end

  def create
    @change = Change.new(params[:change])
    if @change.save
      notice(admins_path)
    else
      error(:new)
    end
  end

  # def edit

  def update
    if @change.update_attributes(params[:change])
      notice(admins_path)
    else
      error(:edit)
    end
  end

  private
  def find_change
    @change = Change.find(params[:id])
  end
end
