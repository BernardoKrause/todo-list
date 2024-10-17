class AddConcluidoToTasks < ActiveRecord::Migration[7.2]
  def change
    add_column :tasks, :concluido, :boolean, default: false
  end
end
