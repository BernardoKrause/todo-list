class AddUserIdToLists < ActiveRecord::Migration[7.2]
  def change
    add_reference :lists, :user, null: true, foreign_key: true
  end
end
