class ChangeTextToTextInTasks < ActiveRecord::Migration
  def self.up
    change_column :tasks, :text, :text
  end

  def self.down
    change_column :tasks, :text, :string
  end
end
