class AddPriorityToTasks < ActiveRecord::Migration[7.2]
  def change
    add_column :tasks, :priority, :integer, default: 0
  end
end
