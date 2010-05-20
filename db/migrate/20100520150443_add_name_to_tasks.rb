class AddNameToTasks < ActiveRecord::Migration
  def self.up
    add_column :tasks, :name, :string
    Task.all.each do |task|
      task.name = task.text
      task.text = nil
      task.save
    end
  end

  def self.down
    Task.all.each do |task|
      task.text = task.name
      task.save
    end
    remove_column :tasks, :name
  end
end
