class TasksController < ApplicationController
  before_filter :authenticate
  before_filter :find_task, :only => [:edit, :update, :destroy, :complete]

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(params[:task])
    if @task.save
      notice(admins_path)
    else
      error(:new)
    end
  end

  # def edit

  def update
    if @task.update_attributes(params[:task])
      notice(admins_path)
    else
      error(:edit)
    end
  end

  def destroy
    @task.destroy
    notice(admins_path)
  end

  def complete
    @task.completed = true
    @task.position = 0
    @task.save
    redirect_to(admins_path)
  end

  def sort
    params[:tasks_list].each_with_index do |id, index|
      unless id.blank?
        task = Task.find(id)
        task.position = index + 1 unless task.completed
        task.save
      end
      #Task.update_all(['position = ?', index + 1], ['id = ?', id])
    end
    render :update do |page|
      page.reload
    end
  end

  private
  def find_task
    @task = Task.find(params[:id])
  end
end
