class AddBudgetToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :budget, :float
  end

  def self.down
    remove_column :users, :budget
  end
end
